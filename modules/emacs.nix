{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: with epkgs; [
      use-package
      evil
      evil-collection
      general
      which-key
      vertico
      orderless
      marginalia
      consult
      embark
      embark-consult
      helpful
      doom-modeline
      all-the-icons
      all-the-icons-completion
      doom-themes
      solaire-mode
      org-modern
      org-superstar
      org-appear
      toc-org
      visual-fill-column
      mixed-pitch
    ];
  };

  # 使用守护进程提升启动速度，尤其是 emacsclient 工作流。
  services.emacs = {
    enable = true;
    defaultEditor = false;
    startWithUserSession = "graphical";
  };

  # org-mode 目录和附件目录预创建。
  home.file."org/.keep".text = "";
  home.file."org/attachments/.keep".text = "";

  xdg.configFile."emacs/init.el".text = ''
    ;; -*- lexical-binding: t; -*-

    ;; Package bootstrap (Nix already provides packages, keep startup clean)
    (require 'package)
    (setq package-enable-at-startup nil)

    ;; Base UI tuning
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (blink-cursor-mode -1)
    (global-hl-line-mode 1)
    (setq inhibit-startup-screen t
          initial-scratch-message nil
          ring-bell-function 'ignore
          use-dialog-box nil
          visible-bell nil)

    ;; Font setup: prefer Maple Mono NF CN in WSL; fallback to JetBrains Mono Nerd Font.
    (cond
     ((find-font (font-spec :name "Maple Mono NF CN"))
      (set-face-attribute 'default nil :font "Maple Mono NF CN-12"))
     ((find-font (font-spec :name "JetBrainsMono Nerd Font"))
      (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-12")))
    (when (find-font (font-spec :name "Noto Sans CJK SC"))
      (set-face-attribute 'variable-pitch nil :font "Noto Sans CJK SC-13"))

    ;; Better defaults
    (setq-default indent-tabs-mode nil
                  tab-width 4
                  fill-column 100
                  cursor-type 'bar)
    (electric-pair-mode 1)
    (show-paren-mode 1)
    (global-display-line-numbers-mode 1)
    (setq display-line-numbers-type 'relative)
    (setq-default line-spacing 0.18)

    ;; Smooth UX details
    (pixel-scroll-precision-mode 1)
    (setq scroll-conservatively 101
          scroll-margin 5
          scroll-step 1)

    ;; Keep customization out of init.el generated text.
    (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
    (when (file-exists-p custom-file)
      (load custom-file t))

    (require 'use-package)
    (setq use-package-always-ensure nil)

    ;; Modal editing close to Neovim muscle memory.
    (use-package evil
      :init
      (setq evil-want-integration t
            evil-want-keybinding nil
            evil-want-C-u-scroll t
            evil-undo-system 'undo-redo)
      :config
      (evil-mode 1))

    (use-package evil-collection
      :after evil
      :config
      (evil-collection-init))

    (use-package general
      :after evil
      :config
      (general-create-definer cake/leader
        :states '(normal visual emacs)
        :prefix "SPC"
        :global-prefix "C-SPC")

      (cake/leader
        "f"  '(:ignore t :which-key "file")
        "ff" '(find-file :which-key "find file")
        "fr" '(recentf-open-files :which-key "recent files")
        "b"  '(:ignore t :which-key "buffer")
        "bb" '(consult-buffer :which-key "switch buffer")
        "bd" '(kill-current-buffer :which-key "kill buffer")
        "w"  '(:ignore t :which-key "window")
        "wv" '(split-window-right :which-key "split vertical")
        "ws" '(split-window-below :which-key "split horizontal")
        "wd" '(delete-window :which-key "delete window")
        "pf" '(consult-ripgrep :which-key "project grep")
        "oa" '(org-agenda :which-key "org agenda")
        "oc" '(org-capture :which-key "org capture")
        "ot" '(org-todo-list :which-key "org todo")))

    (use-package which-key
      :init (which-key-mode 1)
      :config
      (setq which-key-idle-delay 0.35))

    ;; Modern completion stack
    (use-package vertico
      :init
      (vertico-mode 1)
      :config
      (setq vertico-cycle t))

    (use-package orderless
      :init
      (setq completion-styles '(orderless basic)
            completion-category-defaults nil
            completion-category-overrides '((file (styles partial-completion)))))

    (use-package marginalia
      :init (marginalia-mode 1))

    (use-package consult)

    (use-package embark
      :bind (("C-." . embark-act)
             ("C-;" . embark-dwim)
             ("C-h B" . embark-bindings)))

    (use-package embark-consult
      :after (embark consult))

    (use-package helpful
      :bind (("C-h f" . helpful-callable)
             ("C-h v" . helpful-variable)
             ("C-h k" . helpful-key)
             ("C-h x" . helpful-command)))

    ;; Visual polish inspired by your Nixvim setup.
    (use-package doom-themes
      :config
      (load-theme 'doom-ayu-mirage t)
      (doom-themes-org-config))

    (use-package solaire-mode
      :after doom-themes
      :config
      (solaire-global-mode 1))

    (use-package doom-modeline
      :init (doom-modeline-mode 1)
      :config
      (setq doom-modeline-height 30
            doom-modeline-icon t
            doom-modeline-buffer-file-name-style 'truncate-upto-project))

    (use-package all-the-icons
      :if (display-graphic-p))

    (use-package all-the-icons-completion
      :after marginalia
      :init
      (all-the-icons-completion-mode 1))

    ;; Org core
    (setq org-directory (expand-file-name "~/org")
          org-default-notes-file (expand-file-name "inbox.org" org-directory)
          org-agenda-files (list org-directory)
          org-log-done 'time
          org-startup-indented t
          org-hide-emphasis-markers t
          org-pretty-entities t
          org-ellipsis "  ▼"
          org-startup-with-inline-images t
          org-image-actual-width '(700)
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-edit-src-content-indentation 0)

    (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCEL(c@)")))

    (setq org-capture-templates
          '(("t" "Todo" entry
             (file+headline "~/org/inbox.org" "Tasks")
             "* TODO %?\n  %U\n  %a\n")
            ("n" "Note" entry
             (file+headline "~/org/inbox.org" "Notes")
             "* %? :note:\n%U\n%a\n")
            ("j" "Journal" entry
             (file+olp+datetree "~/org/journal.org")
             "* %?\nEntered on %U\n")))

    (with-eval-after-load 'org
      (define-key org-mode-map (kbd "C-c l") #'org-store-link)
      (define-key org-mode-map (kbd "C-c a") #'org-agenda)
      (define-key org-mode-map (kbd "C-c c") #'org-capture))

    ;; Org aesthetics and writing comfort
    (use-package mixed-pitch
      :hook (org-mode . mixed-pitch-mode))

    (use-package visual-fill-column
      :hook (org-mode . cake/org-centered-mode)
      :config
      (defun cake/org-centered-mode ()
        "Center org buffers with comfortable reading width."
        (setq visual-fill-column-width 110
              visual-fill-column-center-text t)
        (visual-fill-column-mode 1)))

    (use-package org-superstar
      :hook (org-mode . org-superstar-mode)
      :config
      (setq org-superstar-remove-leading-stars t
            org-superstar-headline-bullets-list '("◉" "○" "●" "◆" "▶")))

    (use-package org-modern
      :after org
      :hook (org-mode . org-modern-mode)
      :config
      (setq org-modern-star nil
            org-modern-list '(?• ?◦ ?▹ ?▸)
            org-modern-table nil
            org-modern-keyword nil
            org-modern-todo t
            org-modern-tag t
            org-modern-priority t))

    (use-package org-appear
      :hook (org-mode . org-appear-mode)
      :config
      (setq org-appear-autoemphasis t
            org-appear-autolinks t
            org-appear-autosubmarkers t))

    (use-package toc-org
      :hook (org-mode . toc-org-mode))

    ;; Keep code editing focused, disable relative numbers in org prose buffers.
    (add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

    ;; Backup files in one place, keep working tree clean.
    (setq backup-directory-alist
          `(("." . ,(expand-file-name "backups" user-emacs-directory)))
          auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

    ;; Ensure recent files and history are available.
    (recentf-mode 1)
    (savehist-mode 1)
    (setq recentf-max-saved-items 200)
  '';
}
