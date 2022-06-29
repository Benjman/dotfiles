/* user and group to drop privileges to */
static const char *user  = "ben";
static const char *group = "ben";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* time in seconds before the monitor shuts down */
static const int monitortime = 5;

/* time in seconds to cancel lock with mouse movement */
static const int timetocancel = monitortime;
