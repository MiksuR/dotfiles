/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#040d1c",     /* after initialization */
	[INPUT] =  "#00c1c1",   /* during input */
	[FAILED] = "#ff5300",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
