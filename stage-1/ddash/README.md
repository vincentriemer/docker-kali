dash apt utility helpers
------------------------

`ddash` (`docker dash`) provides a few helper dash commands for dockerfiles.
The primary helper command is `daft` (`docker apt-fast`) which is a basic
front-end wrapper for apt install commands within dockerfiles which provides
useful status line progress reporting output for users who are
 interactively/iteratively building up or testing various dockerfiles.

`apt-out.sh` is a two line apt output status line and progress report.

`apt-fast` and `apt-fast.conf` are slightly modified copies of the
(apt-fast)[1] allowing usage with `apt-fast-progress.sh` (Ariai2)[2].

[1]:https://github.com/ilikenwf/apt-fast
[2]:https://github.com/tatsuhiro-t/aria2

