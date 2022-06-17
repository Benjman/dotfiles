/* user and group to drop privileges to */
static const char *user = "ben";
static const char *group = "ben";

static const char *colorname[NUMCOLS] = {
    [INIT] = "#333333",   /* after initialization */
    [INPUT] = "#005577",  /* during input */
    [FAILED] = "#880000", /* wrong password */
    [CAPS] = "red",       /* CapsLock on */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* default message */
static const char *message = "Suckless: Software that sucks less.";

/* text color */
static const char *text_color = "#ffffff";

/* text size (must be a valid size) */
static const char *font_name = "6x10";
