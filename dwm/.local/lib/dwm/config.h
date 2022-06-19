/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx = 1;  /* border pixel of windows */
static const unsigned int snap     = 32; /* snap pixel */
static const int showbar           = 1;  /* 0 means no bar */
static const int topbar            = 1;  /* 0 means bottom bar */
static const char *fonts[]         = {
            "DejaVuSansMono Nerd Font:style=Regular:size=10",
            "NotoColorEmoji:pixelsize=10:antialias=true:autohint=true",
};
// static const char dmenufont[]      = "monospace:size=10";
static const char col_gray1[]  = "#222222";
static const char col_gray2[]  = "#444444";
static const char col_gray3[]  = "#bbbbbb";
static const char col_gray4[]  = "#eeeeee";
static const char col_cyan[]   = "#005577";
static const char *colors[][3] = {
  /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, col_gray1, col_gray2},
    [SchemeSel]  = {col_gray4, col_cyan,  col_cyan },
};
/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
  /* xprop(1):
  *	WM_CLASS(STRING) = instance, class
  *	WM_NAME(STRING) = title
  */
  /* class      instance    title       tags mask     isfloating   monitor */
    {"Gimp",    NULL, NULL, 0,      1, -1},
    {"Firefox", NULL, NULL, 1 << 8, 0, -1},
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
  /* symbol     arrange function */
    {"[]=", tile   }, /* first entry is default */
    {"><>", NULL   }, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                                                                        \
  {MODKEY, KEY, view, {.ui = 1 << TAG}}, {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},                              \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}}, {                                                                        \
    MODKEY | ControlMask | ShiftMask, KEY, toggletag, { .ui = 1 << TAG }                                                         \
  }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                                                                               \
  {                                                                                                                              \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                                                                         \
  }

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2]             = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]       = {"dmenu_run", "-m", dmenumon, NULL};
static const char *termcmd[]        = {"/bin/alacritty", NULL};
static const char *brightness[2][4] = {
    {"xbacklight", "-inc", "5", NULL},
    {"xbacklight", "-dec", "5", NULL}
};
static const char *volume[3][4] = {
    {"pulsemixer", "--change-volume", "+5", NULL},
    {"pulsemixer", "--change-volume", "-5", NULL},
    {"pulsemixer", "--toggle-mute",   "",   NULL}
};

static Key keys[] = {
    TAGKEYS(XK_1, 0),
    TAGKEYS(XK_2, 1),
    TAGKEYS(XK_3, 2),
    TAGKEYS(XK_4, 3),
    TAGKEYS(XK_5, 4),
    TAGKEYS(XK_6, 5),
    TAGKEYS(XK_7, 6),
    TAGKEYS(XK_8, 7),
    TAGKEYS(XK_9, 8),

 /* modifier            key                       function        argument */
    {0,                  XF86XK_AudioLowerVolume,  spawn,          {.v = volume[1]}                                    },
    {0,                  XF86XK_AudioMute,         spawn,          {.v = volume[2]}                                    },
    {0,                  XF86XK_AudioRaiseVolume,  spawn,          {.v = volume[0]}                                    },
    {0,                  XF86XK_MonBrightnessDown, spawn,          {.v = brightness[1]}                                },
    {0,                  XF86XK_MonBrightnessUp,   spawn,          {.v = brightness[0]}                                },
    {MODKEY | ShiftMask, XK_0,                     tag,            {.ui = ~0}                                          },
    {MODKEY,             XK_0,                     view,           {.ui = ~0}                                          },
    {MODKEY,             XK_Return,                zoom,           {0}                                                 },
    {MODKEY,             XK_Tab,                   view,           {0}                                                 },
    {MODKEY,             XK_b,                     togglebar,      {0}                                                 },
    {MODKEY | ShiftMask, XK_c,                     killclient,     {0}                                                 },
    {MODKEY | ShiftMask, XK_comma,                 tagmon,         {.i = -1}                                           },
    {MODKEY,             XK_comma,                 focusmon,       {.i = -1}                                           },
    {MODKEY,             XK_d,                     spawn,          SHCMD("dmenu_run")                                  },
    {MODKEY,             XK_d,                     spawn,          SHCMD("dmenu_run")                                  },
 // {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY,             XK_f,                     setlayout,      {.v = &layouts[1]}                                  },
    {MODKEY,             XK_h,                     setmfact,       {.f = -0.05}                                        },
 // {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY,             XK_j,                     focusstack,     {.i = +1}                                           },
    {MODKEY,             XK_k,                     focusstack,     {.i = -1}                                           },
 // {MODKEY,             XK_l,                     setmfact,       {.f = +0.05}                                        },
    {MODKEY,             XK_m,                     setlayout,      {.v = &layouts[2]}                                  },
    {MODKEY | ShiftMask, XK_l,                     spawn,          SHCMD("slock")                                      },
    {MODKEY,             XK_p,                     spawn,          SHCMD("passmenu")                                   },
    {MODKEY | ShiftMask, XK_period,                tagmon,         {.i = +1}                                           },
    {MODKEY,             XK_period,                focusmon,       {.i = +1}                                           },
    {MODKEY | ShiftMask, XK_q,                     quit,           {0}                                                 },
    {MODKEY,             XK_s,                     spawn,          SHCMD("/home/ben/.local/lib/scripts/scriptsmenu.sh")},
    {MODKEY | ShiftMask, XK_space,                 togglefloating, {0}                                                 },
    {MODKEY,             XK_space,                 setlayout,      {0}                                                 },
    {MODKEY,             XK_t,                     setlayout,      {.v = &layouts[0]}                                  },
    {MODKEY,             XK_t,                     spawn,          {.v = termcmd}                                      },
    {MODKEY,             XK_w,                     spawn,          SHCMD("$BROWSER")                                   },
    {MODKEY,             XK_x,                     spawn,          SHCMD("ls | dmenu -p \"hello\"")                    },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click          mask    button   function        argument */
    {ClkClientWin,  MODKEY, Button1, movemouse,      {0}               },
    {ClkClientWin,  MODKEY, Button2, togglefloating, {0}               },
    {ClkClientWin,  MODKEY, Button3, resizemouse,    {0}               },
    {ClkLtSymbol,   0,      Button1, setlayout,      {0}               },
    {ClkLtSymbol,   0,      Button3, setlayout,      {.v = &layouts[2]}},
    {ClkStatusText, 0,      Button2, spawn,          {.v = termcmd}    },
    {ClkStatusText, 0,      Button1, sigstatusbar,   {.i = 1}          },
    {ClkStatusText, 0,      Button2, sigstatusbar,   {.i = 2}          },
    {ClkStatusText, 0,      Button3, sigstatusbar,   {.i = 3}          },
    {ClkTagBar,     0,      Button1, view,           {0}               },
    {ClkTagBar,     0,      Button3, toggleview,     {0}               },
    {ClkTagBar,     MODKEY, Button1, tag,            {0}               },
    {ClkTagBar,     MODKEY, Button3, toggletag,      {0}               },
    {ClkWinTitle,   0,      Button2, zoom,           {0}               },
};
