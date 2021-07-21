# I believe this is to fix an issue where the tilde key does not work correctly
sed '/key <LSGT>/a \ \ \ \ // MANUAL FIX BS\n\ \ \ \ key <LSGT> { [ grave, asciitilde, grave, asciitilde ] };' \
    /usr/share/X11/xkb/symbols/pc -i
