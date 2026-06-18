{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # 基础配置
    baseIndex = 1;  # 窗口编号从 1 开始
    clock24 = true;  # 使用 24 小时制
    escapeTime = 0;  # 减少 ESC 键延迟
    historyLimit = 10000;  # 历史记录行数
    
    # 终端配置
    terminal = "screen-256color";
    
    # 启用鼠标支持
    mouse = true;
    
    # 自定义前缀键（默认 Ctrl-b）
    # prefix = "C-a";  # 如果想改成 Ctrl-a，取消注释这行

    extraConfig = ''
      # -- general
      # set-option default-path "$PWD"
      # set-option -g default-command "zsh -c 'cd \"$PWD\" && exec zsh'"

      setw -g xterm-keys on
      set -s escape-time 0
      set -sg repeat-time 300
      set -s focus-events on
      set -g mouse on
      set -sg exit-empty on

      set -q -g status-utf8 on
      setw -q -g utf8 on

      set -g visual-activity off
      setw -g monitor-activity off
      setw -g monitor-bell off

      set -g history-limit 10000

      # set-hook -g pane-focus-in "run -b 'bash ~/.config/tmux/fzf_panes.tmux update_mru_pane_ids'"
      # bind -n M-w run -b 'bash ~/.config/tmux/fzf_panes.tmux new_window'

      # reload configuration
      bind r source-file ~/.config/tmux/tmux.conf \; display '~/.config/tmux/tmux.conf sourced'

      set -ga update-environment '\
      DISPLAY DBUS_SESSION_BUS_ADDRESS \
      QT_IM_MODULE QT_QPA_PLATFORMTHEME \
      SESSION_MANAGER \
      XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME\
      XDG_MENU_PREFIX XDG_RUNTIME_DIR XDG_SESSION_CLASS \
      XDG_SESSION_DESKTOP XDG_SESSION_TYPE XDG_CURRENT_DESKTOP \
      XMODIFIERS \
      FZF_DEFAULT_OPTS \
      '
      set-hook -g client-attached 'run -b "cut -c3- ~/.config/tmux/tmux.conf | sh -s update_env_event"'

      # -- prefix
      unbind C-b
      set -g prefix 'C-a'
      bind C-a send-prefix

      # -- display
      set -g base-index 1
      setw -g pane-base-index 1

      setw -g automatic-rename on
      set -g renumber-windows on

      set -g set-titles on

      set -g display-panes-time 2000
      set -g display-time 2000

      set -g status-interval 1

      # -- navigation

      # create session
      bind C-c new-session

      # window management
      bind -n M-o new-window -c "#{pane_current_path}"
      bind -n M-O break-pane
      bind -n M-Q kill-pane

      # window navigation
      unbind n
      unbind p
      unbind 1
      unbind 2
      unbind 3
      unbind 4
      unbind 5
      unbind 6
      unbind 7
      unbind 8
      unbind 9
      unbind 0
      bind -r C-p previous-window
      bind -r C-n next-window

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9


      bind -n M-! join-pane -t :1
      bind -n M-@ join-pane -t :2
      bind -n 'M-#' join-pane -t :3
      bind -n 'M-$' join-pane -t :4
      bind -n M-% join-pane -t :5
      bind -n M-^ join-pane -t :6
      bind -n M-& join-pane -t :7
      bind -n M-* join-pane -t :8
      bind -n M-( join-pane -t :9

      bind k split-window -vb -c "#{pane_current_path}"
      bind j split-window -v -c "#{pane_current_path}"
      bind h split-window -hb -c "#{pane_current_path}"
      bind l split-window -h -c "#{pane_current_path}"

      bind -n M-f resize-pane -Z

      # pane navigation
      bind 1 select-pane -t:.1
      bind 2 select-pane -t:.2
      bind 3 select-pane -t:.3
      bind 4 select-pane -t:.4
      bind 5 select-pane -t:.5
      bind 6 select-pane -t:.6
      bind 7 select-pane -t:.7
      bind 8 select-pane -t:.8
      bind 9 select-pane -t:.9
      bind 0 select-pane -t:.10
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
      bind > swap-pane -D
      bind < swap-pane -U
      bind | swap-pane
      bind -n M-Space next-layout

      bind W choose-tree -Z
      bind S choose-tree 'move-pane -v -s "%%"'
      bind V choose-tree 'move-pane -h -s "%%"'

      # pane resizing
      bind -n M-H resize-pane -L 3
      bind -n M-J resize-pane -D 3
      bind -n M-K resize-pane -U 3
      bind -n M-L resize-pane -R 3

      set -g status-keys emacs
      set -g mode-keys vi

      bind -n M-v copy-mode

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi v send-keys -X begin-selection
      # C-v 的键位似乎会和终端冲突
      bind -T copy-mode-vi C-M-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi Y send-keys -X copy-end-of-line
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi = send-keys -X search-again
      bind -T copy-mode-vi = send-keys -X search-reverse


      bind b list-buffers
      bind p paste-buffer

      # -- toggle_syn_input
      bind C-g if-shell '[[ $(tmux showw synchronize-panes | cut -d\  -f2) == "on" ]]' \
      'setw synchronize-panes off; set -g pane-border-style fg=magenta' \
      'setw synchronize-panes on; set -g pane-border-style fg=red'

      # -- toggle_status
      bind s if-shell '[[ $(tmux show -g status | cut -d\  -f2) == "on" ]]' \
      'set -g status off' \
      'set -g status on'

      # -- theme
      #set -g status off

      # panes
      #setw -g pane-border-status bottom
      setw -g pane-border-format '#[bold]#{?#{&&:#{pane_active},#{client_prefix}},#[underscore],}\
      #{?pane_active,❐ #S:#I/#{session_windows} ,}#{?window_zoomed_flag,⬢,❄} #P ⇒ #{pane_tty} #{pane_current_command}'
      #set -g pane-active-border-style fg=brightblue
      #set -g pane-border-style fg=magenta

      # windows
      set -g status-justify 'centre'
      set -g status-left-length 90
      set -g status-right-length 140
      setw -g window-status-separator \'\'

      # default statusbar colors
      set -g status-bg black
      #set -g status-left ' #[fg=magenta,bold]❐ #S'
      #set -g status-left '#[fg=brightyellow] #{?client_prefix,⌨ ,  }  #[fg=magenta,bold] %Y-%m-%d %H:%M '
      #set -g status-right '#(rainbarf --battery --remaining --bolt --tmux --rgb)'
      #set -g status-left "#[fg=magenta,bold] %Y-%m-%d %H:%M | #[fg=brightblue]#(curl icanhazip.com) #(ifconfig en0 | grep 'inet ' | awk '{print \"en0 \" $2}') #(ifconfig en1 | grep 'inet ' | awk '{print \"en1 \" $2}') #(ifconfig en3 | grep 'inet ' | awk '{print \"en3 \" $2}') #(ifconfig tun0 | grep 'inet ' | awk '{print \"vpn \" $2}') "
      setw -g window-status-format '#[fg=brightblue] #I #W '
      setw -g window-status-current-format '#[fg=magenta,bold] #I #W:#F'
      setw -g window-status-activity-style bg=black
      setw -g window-status-bell-style bg=black
      #set-window-option -g window-status-current-format "#[fg=colour235, bg=colour27]⮀#[fg=colour255, bg=colour27] #I ⮁ #W #[fg=colour27, bg=colour235]⮀"

      # set-option -g status-left "#(~/.config/tmux/tmux-powerline/powerline.sh left)"
      # set-option -g status-right "#(~/.config/tmux/tmux-powerline/powerline.sh right)"

      # set -g default-shell /usr/bin/fish
    '';
    
    /*
    # 额外配置
    extraConfig = ''
      # 分屏快捷键
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      
      # 面板切换（Vim 风格）
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # 面板大小调整
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # 重新加载配置文件
      bind r source-file ~/.config/tmux/tmux.conf \; display "配置已重新加载"
      
      # 复制模式使用 vi 键绑定
      setw -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      # 状态栏配置
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'bg=colour234 fg=colour137 dim'
      set -g status-left ""
      set -g status-right '#[fg=colour233,bg=colour241,bold] %Y-%m-%d #[fg=colour233,bg=colour245,bold] %H:%M:%S '
      set -g status-right-length 50
      set -g status-left-length 20
      
      # 窗口状态栏配置
      setw -g window-status-current-style 'fg=colour1 bg=colour19 bold'
      setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '
      setw -g window-status-style 'fg=colour9 bg=colour18'
      setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
      
      # 面板边框配置
      set -g pane-border-style 'fg=colour238'
      set -g pane-active-border-style 'fg=colour51'
      
      # 消息样式
      set -g message-style 'fg=colour232 bg=colour166 bold'
    '';
    */
    
    # 插件配置（可选）
    plugins = with pkgs.tmuxPlugins; [
      # sensible  # 基础合理配置
      # yank      # 系统剪贴板集成
      # resurrect # 保存和恢复 tmux 会话
      # continuum # 自动保存 tmux 会话
    ];
  };
}
