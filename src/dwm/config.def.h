/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int splitstatus        = 1;        /* 1 for split status items */
static const char *splitdelim        = ";";       /* Character used for separating status */
static const char *fonts[]          = { "monospace:size=12","foontawesome:size=12" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#282a36";
static const char col_gray2[]       = "#282a36";
static const char col_gray3[]       = "#96b5b4";
static const char col_gray4[]       = "#d7d7d7";
static const char col_cyan[]        = "#4d4d4d";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, "#C0C0C0" },
	[SchemeSel]  = { col_gray4, col_cyan,  "#00ff00"  },
};


/* Application commands */

static const char *todocmd[] = { "/home/rami/ScriptsForOS/dmenu/todo-dmenu", NULL };
static const char *googlechromeunstable[] = { "google-chrome-unstable", NULL };
static const char *telegramcmd[] = { "/home/rami/Programs/Telegram/Telegram", NULL };
static const char *postmancmd[] = { "/home/rami/Programs/Postman/Postman", NULL };
static const char *vscodecmd[] = { "code", NULL };
static const char *windsurfcmd[] = { "windsurf", NULL };
static const char *teamspeakcmd[] = { "/home/rami/Programs/TeamSpeak6/TeamSpeak", NULL };
static const char *bravecmd[] = { "brave-browser", NULL };
static const char *audaciouscmd[] = { "audacious", NULL };
static const char *obscmd[] = { "obs", NULL };
static const char *clioncmd[] = { "/home/rami/Programs/clion-2024.3.2/bin/clion.sh", NULL };
static const char *open_rdp_cmd[] = { "/home/rami/ScriptsForOS/open_rdp.sh", NULL };
static const char *webstormcmd[] = { "/home/rami/Programs/WebStorm-243.23654.157/bin/webstorm.sh", NULL };
static const char *termiuscmd[] = { "termius-app", NULL };
static const char *wiresharkcmd[] = { "wireshark", NULL };
static const char *xmindcmd[] = { "xmind", NULL };
static const char *remmina[] = {"remmina",NULL};
static const char *floorp[] = { "floorp", NULL };
//Swap Monitor 1 Click
static void togglemon(const Arg *arg) {
    static int lastmon = 0;  // Store last used monitor
    int curmon = selmon->num;

    // Switch to the other monitor
    if (lastmon != curmon) {
        lastmon = curmon;
        focusmon(&(Arg){.i = lastmon});
    } else {
        lastmon = (curmon == 0) ? 1 : 0;  // If on monitor 0, go to 1, else go to 0
        focusmon(&(Arg){.i = lastmon});
    }
}


// CUSTOM SCRIPTS Dmenu
static const char *powermenu[] = { "/home/rami/ScriptsForOS/powermenu-Dmenu.sh", NULL };
static const char *upvol[]   = { "amixer", "set", "Master", "5%+",     NULL };
static const char *downvol[] = { "amixer", "set", "Master", "5%-",     NULL };
static const char *mutevol[] = { "amixer", "set", "Master", "toggle",  NULL };



/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
        /* xprop(1):
         *      WM_CLASS(STRING) = instance, class
         *      WM_NAME(STRING) = title
         */
        /* class      instance    title       tags mask     isfloating   monitor */
        { "Brave-browser", NULL,  NULL,       0,             0,           -1 },
        { NULL,       NULL,       NULL,       0,             0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.65; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const LayoutMonitorRule lm_rules[] = {
	/* >=w, >=h, req'd layout, new nmaster, new mfact */
	{ 3000, 0,   0,            2,           0.66 },
};

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
};

/* key definitions */
#define WINKEY Mod4Mask
#define MODKEY Mod1Mask
#define Super Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|WINKEY,                KEY,      nview,          {.ui = 1 << TAG} }, \
	{ MODKEY|WINKEY|ControlMask,    KEY,      ntoggleview,    {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask,                       KEY,      focusnthmon,    {.i  = TAG } }, \
        { MODKEY|ControlMask|ShiftMask,             KEY,      tagnthmon,      {.i  = TAG } },


/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *layoutmenu_cmd = "layoutmenu.sh";

static const Key keys[] = {
	/* modifier                     key        function        argument */
        { ControlMask|ShiftMask,        XK_t,      spawn,          {.v = todocmd } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ControlMask,           XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
        { MODKEY,                       XK_Down,    focusstack,     {.i = +1 } },
        { MODKEY,                       XK_Up,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
        { MODKEY,                       XK_Left,   setmfact,       {.f = -0.05} },
        { MODKEY,                       XK_Right,  setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ControlMask,           XK_k,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ ControlMask|ShiftMask,	XK_Tab,	   togglemon,	   {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
        { ControlMask, 	                XK_Delete,      quit,           {0} },
        { MODKEY|Mod1Mask,             XK_q,      spawn,          {.v = powermenu } },
        { 0,                            XF86XK_AudioRaiseVolume,  spawn,    {.v = upvol   } },
        { 0,                            XF86XK_AudioLowerVolume,  spawn,    {.v = downvol } },
        { 0,                            XF86XK_AudioMute,         spawn,    {.v = mutevol } },
   /* Application launchers */
    /* Note: Some keys will override default DWM functions */
    /* Comment out conflicting DWM bindings above if you want to use these */
    { Super,                        XK_f,                  spawn,          {.v = floorp } },
    { Super|ShiftMask,              XK_c,                  spawn,          {.v = googlechromeunstable } },
    { Super,                        XK_t,                  spawn,          {.v = telegramcmd } },
    { Super,                        XK_p,                  spawn,          {.v = postmancmd } },
    { Super,                        XK_c,                  spawn,          {.v = vscodecmd } },
    { Super,                        XK_w,                  spawn,          {.v = windsurfcmd } },
    { Super,                        XK_s,                  spawn,          {.v = teamspeakcmd } },
    { Super,                        XK_b,                  spawn,          {.v = bravecmd } },
    { Super,                        XK_m,                  spawn,          {.v = audaciouscmd } },
    { Super,                        XK_o,                  spawn,          {.v = obscmd } },
    { Super,                        XK_n,                  spawn,          {.v = clioncmd } },
    { Super,                        XK_r,                  spawn,          {.v = open_rdp_cmd } },
    { Super|ShiftMask,              XK_w,                  spawn,          {.v = webstormcmd } }, /* Capital W for WebStorm */
    { Super|ShiftMask,              XK_t,                  spawn,          {.v = termiuscmd } }, /* Capital T for Termius */
    { Super,                        XK_i,                  spawn,          {.v = wiresharkcmd } },
    { Super,                        XK_x,                  spawn,          {.v = xmindcmd } },
    { Super          ,              XK_r,                  spawn,          {.v = remmina } },
    { ControlMask|ShiftMask,        XK_s,                  spawn,         SHCMD("maim -s 2>/dev/null | xclip -selection clipboard -t image/png") },
    { ControlMask|ShiftMask,        XK_Page_Up,            spawn,         SHCMD("maim 2>/dev/null | xclip -selection clipboard -t image/png") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkMonNum,            0,              Button1,        focusmon,       {.i = +1} },
	{ ClkMonNum,            0,              Button3,        focusmon,       {.i = -1} },
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY|WINKEY,  Button1,        nview,          {0} },
	{ ClkTagBar,            MODKEY|WINKEY,  Button3,        ntoggleview,    {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

