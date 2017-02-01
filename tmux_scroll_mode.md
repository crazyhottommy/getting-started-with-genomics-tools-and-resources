
### install tmux



### tmux config file


### scroll mode

One problem with `screen` or `tmux` is that you have to press `control + a + [` to enter the copy mode, and and `control + a + ]` to paste it.
I want to just use the mouse to scroll up and down and copy/paste.

read this long thread github issue: https://github.com/tmux/tmux/issues/145
The solution that worked for me:

1. download the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Put this at the bottom of .tmux.conf:

```
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'

```
2. Now install [tmux-better-mouse-mode](https://github.com/NHDaly/tmux-better-mouse-mode) plugin.

open your `.tmux.conf`.

To enable mouse-mode in tmux 2.1+, put the following line in your ~/.tmux.conf:

```
set-option -g mouse on

```

then add the following line to your .tmux.conf file:

```
set -g @plugin 'nhdaly/tmux-better-mouse-mode'
```

3. install it

```
# start a new session
tmux

# install plugin
`control + a + I (captial)` to install all the plugins.

```
Now if you scroll up with your mouse, you will enter into copy mode automatically, and when you scroll down to the end of the current screen,
you will exit the copy mode automatically. 

4. copy and paste
If you scroll up and select the text you want to copy by left-click and drag, you will exit
the copy mode instantly, and the content you selected will be copied in the buffer. You just need to `control + a + ]` to paste it.
very cool!



