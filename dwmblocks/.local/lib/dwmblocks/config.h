/**
 * Signals can be sent to the dwmblocks process to individual scripts, by either the pkill with
 * the RTMIN offset, or the kill command by adding 34 as the offset:
 *      pkill   -RTMIN+8    $(pidof dwmblocks)      # this would signal the weather module
 *      kill    -43         $(pidof dwmblocks)      # this would signal the volume module
 **/

static const Block blocks[] = {
  /* icon   command             update interval     signal */
    {"",    "sb-memory",        10,                 6},
    {"",    "sb-cpu",           10,                 3},
    {"",    "sb-battery",       300,                1},
    {"",    "sb-internet",      5,                  5},
    {"",    "sb-mouse",         300,                7},
    {"",    "sb-headphones",    300,                4},
    {"",    "sb-volume",        0,                  10},
    {"",    "sb-weather",       900,                8},
    {"",    "sb-clock",         1,                  2},
};

static const char *delim = " | ";
