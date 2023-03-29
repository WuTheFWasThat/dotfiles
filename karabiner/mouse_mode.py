import os
import json

VIM_MODE_KEY = "return_or_enter"
# VIM_MODE_KEY = "spacebar" # is mostly great except sometimes false negatives
# VIM_MODE_KEY = "d" # is mostly great except sometimes false negatives
# VIM_MODE_KEY = "a" # is mostly great except sometimes false negatives ...

# ACTIVATE_TOGGLE = "m"
DOWN = "j"
UP = "k"
LEFT = "h"
RIGHT = "l"
FAST = "a"
MOUSE = "a"
SLOW = "s"
MOUSE_SLOW = "s"
SCROLL = "d"
LEFT_CLICK = "f"
MIDDLE_CLICK = "v"
RIGHT_CLICK = "g"
LEFT_CLICK_2 = "u"
MIDDLE_CLICK_2 = "i"
RIGHT_CLICK_2 = "o"

MOUSE_SCROLL_SPEED = 64
MOUSE_SPEED = 2400
MOUSE_SPEED_SLOW = 600
MOUSE_SLOW_MULTIPLIER = 0.25
MOUSE_FAST_MULTIPLIER = 2

SIMULTANEOUS_THRESHOLD_MS = 100

def var_is_set(var, value=1):
    """ Returns condition that variable is set. """
    return {
        "type": "variable_if",
        "name": var,
        "value": value
    }

def set_var(var, value=1):
    """ Sets variable to value. """
    return {
        "set_variable": {
            "name": var,
            "value": value
        }
    }

def single_key(key_code, modifiers=()):
    return {
        "key_code": key_code,
        "modifiers": {
            "mandatory": list(modifiers),
            "optional": [
                "any"
            ]
        }
    }

def simultaneous_keys(key_codes, after_up=None, modifiers=()):
    res = {
        "simultaneous": [
            { "key_code": key_code } for key_code in key_codes
        ],
        "simultaneous_options": {
            "key_down_order": "insensitive",
            "key_up_order": "insensitive",
        },
        "modifiers": {
            "mandatory": list(modifiers),
            "optional": [ "any" ],
        }
    }
    if after_up is not None:
        res["simultaneous_options"]["to_after_key_up"] = after_up
    return res

def basic_rule(items):
    return {
        "type": "basic",
        # "parameters": { "basic.simultaneous_threshold_milliseconds": SIMULTANEOUS_THRESHOLD_MS },
        **items
    }


caps_lock_rules = [
    basic_rule({
        "from": single_key("caps_lock"),
        "to": [ { "key_code": "left_control" } ],
        "to_if_alone": [ { "key_code": "escape" } ],
    })
]

# NOTE: this is disabled because escape delay is too annoying
# Doing this with a simple rule instead
# right_command_rules = [
#     basic_rule({
#         "from": single_key("right_command"),
#         "to": [ { "key_code": "right_command" } ],
#         "to_if_alone": [ { "key_code": "escape" } ],
#     })
# ]

shift_rules = [
    basic_rule({
        "from": { "key_code": "left_shift" },
        "to": [ { "key_code": "left_shift" } ],
        "to_if_alone": [
            {
                "key_code": "9",
                "modifiers": [ "left_shift" ]
            }
        ]
    }),
    basic_rule({
        "from": { "key_code": "right_shift" },
        "to": [ { "key_code": "right_shift" } ],
        "to_if_alone": [
            {
                "key_code": "0",
                "modifiers": [ "right_shift" ]
            }
        ]
    }),
    # rolls
    basic_rule({
        "from": {
            "key_code": "left_shift",
            "modifiers": {
                "mandatory": [ "right_shift" ]
            }
        },
        "to": [
            { "key_code": "left_shift" },
            { "key_code": "right_shift" }
        ],
        "to_if_alone": [
            {
                "key_code": "0",
                # why both?
                "modifiers": [ "right_shift", "left_shift" ]
            },
            {
                "key_code": "9",
                "modifiers": [ "right_shift", "left_shift" ]
            }
        ]
    }),
    basic_rule({
        "from": {
            "key_code": "right_shift",
            "modifiers": {
                "mandatory": [ "left_shift" ]
            }
        },
        "to": [
            { "key_code": "right_shift" },
            { "key_code": "left_shift" }
        ],
        "to_if_alone": [
            {
                "key_code": "9",
                "modifiers": [ "right_shift" ]
            },
            {
                "key_code": "0",
                "modifiers": [ "right_shift" ]
            }
        ]
    })
]

SIMULTANEOUS_THRESHOLD_MS = 100
SIMULTANEOUS_THRESHOLD_MS_RULE = { "basic.simultaneous_threshold_milliseconds": SIMULTANEOUS_THRESHOLD_MS }

VIM_KEYS_MODE = "vim_keys_mode"
VIM_KEYS_MOUSE_MODE = "vim_keys_mouse_mode"
VIM_KEYS_SCROLL_MODE = "vim_keys_mode_scroll"
VIM_KEYS_ARROW_MODE = "vim_keys_mode_arrows"

VIM_SUBMODES = [VIM_KEYS_MOUSE_MODE, VIM_KEYS_SCROLL_MODE, VIM_KEYS_ARROW_MODE]
VIM_KEYS_AFTER_UP = [
    set_var(mode, 0)
    for mode in [VIM_KEYS_MODE] + VIM_SUBMODES
]

VIM_SUBMODES_OFF = [
    var_is_set(mode, 0)
    for mode in VIM_SUBMODES
]

def basic_vim_rules(key, to, modifiers=(), extra_conditions=()):
    if key.upper() == key:
        modifiers = ["left_shift", "right_shift"] + list(modifiers)
        key = key.lower()
    else:
        modifiers = []
    return [
        basic_rule({
            "from": single_key(key, modifiers=modifiers),
            "to": [to],
            "conditions": [
                var_is_set(VIM_KEYS_MODE),
            ] + list(extra_conditions)
        }),
        basic_rule({
            "from": simultaneous_keys([VIM_MODE_KEY, key], after_up=VIM_KEYS_AFTER_UP, modifiers=modifiers),
            "to_if_alone": [
                set_var(VIM_KEYS_MODE, 1),
                to,
            ],
            "conditions": list(extra_conditions),
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE,
        }),
    ]

def vim_enter_submode_rules(key, mode, modifiers=()):
    if key.upper() == key:
        modifiers = ["left_shift", "right_shift"] + list(modifiers)
        key = key.lower()
    else:
        modifiers = []
    return [
        basic_rule({
            "from": single_key(key, modifiers=modifiers),
            "to": [
                set_var(mode, 1),
            ],
            "conditions": [
                var_is_set(VIM_KEYS_MODE),
            ],
            "to_after_key_up": [
                set_var(mode, 0),
            ]
        }),
        basic_rule({
            "from": simultaneous_keys([VIM_MODE_KEY, key], after_up=VIM_KEYS_AFTER_UP, modifiers=modifiers),
            "to": [
                set_var(VIM_KEYS_MODE, 1),
                set_var(mode, 1),
            ],
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE,
        }),
    ]

def vim_submode_rules(mode, mode_key, key, to, modifiers=(), extra_conditions=()):
    if key.upper() == key:
        modifiers = ["left_shift", "right_shift"] + list(modifiers)
        key = key.lower()
    else:
        modifiers = []
    extra_conditions = list(extra_conditions)
    return [
        *basic_vim_rules(key, to, extra_conditions=[var_is_set(mode)] + extra_conditions, modifiers=modifiers),
        basic_rule({
            "from": simultaneous_keys([VIM_MODE_KEY, mode_key, key], after_up=VIM_KEYS_AFTER_UP, modifiers=modifiers),
            "to": [
                set_var(VIM_KEYS_MODE, 1),
                set_var(mode, 1),
                to,
            ],
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE,
            "conditions": extra_conditions
        }),
    ]


def vim_scroll_rules(key, to, modifiers=()):
    return vim_submode_rules(VIM_KEYS_SCROLL_MODE, SCROLL, key, to, modifiers=modifiers)

def vim_mouse_rules(key, to, modifiers=()):
    return vim_submode_rules(VIM_KEYS_MOUSE_MODE, MOUSE, key, to, modifiers=modifiers, extra_conditions=[var_is_set(VIM_KEYS_SCROLL_MODE, 0)])


vim_keys_rules = [
    *vim_enter_submode_rules(SCROLL, VIM_KEYS_SCROLL_MODE),
    *vim_scroll_rules(DOWN, { "mouse_key": { "vertical_wheel": MOUSE_SCROLL_SPEED }}),
    *vim_scroll_rules(UP, { "mouse_key": { "vertical_wheel": -MOUSE_SCROLL_SPEED }}),
    *vim_scroll_rules(LEFT, { "mouse_key": { "horizontal_wheel": MOUSE_SCROLL_SPEED }}),
    *vim_scroll_rules(RIGHT, { "mouse_key": { "horizontal_wheel": -MOUSE_SCROLL_SPEED }}),
    # *vim_enter_submode_rules(ARROW, VIM_KEYS_ARROW_MODE),
    *vim_enter_submode_rules(MOUSE, VIM_KEYS_MOUSE_MODE),
    *vim_mouse_rules(DOWN, { "mouse_key": { "y": MOUSE_SPEED }}),
    *vim_mouse_rules(UP, { "mouse_key": { "y": -MOUSE_SPEED }}),
    *vim_mouse_rules(LEFT, { "mouse_key": { "x": -MOUSE_SPEED }}),
    *vim_mouse_rules(RIGHT, { "mouse_key": { "x": MOUSE_SPEED }}),
    *vim_mouse_rules(LEFT_CLICK, { "pointing_button": "button1" }),
    *vim_mouse_rules(MIDDLE_CLICK, { "pointing_button": "button3" }),
    *vim_mouse_rules(RIGHT_CLICK, { "pointing_button": "button2" }),
    *vim_mouse_rules(LEFT_CLICK_2, { "pointing_button": "button1" }),
    *vim_mouse_rules(MIDDLE_CLICK_2, { "pointing_button": "button3" }),
    *vim_mouse_rules(RIGHT_CLICK_2, { "pointing_button": "button2" }),
    *basic_vim_rules(FAST, { "mouse_key": { "speed_multiplier": MOUSE_FAST_MULTIPLIER } }),
    *basic_vim_rules(SLOW, { "mouse_key": { "speed_multiplier": MOUSE_SLOW_MULTIPLIER } }),
    *basic_vim_rules(DOWN, { "key_code": "down_arrow" }, extra_conditions=VIM_SUBMODES_OFF),
    *basic_vim_rules(UP, { "key_code": "up_arrow" }, extra_conditions=VIM_SUBMODES_OFF),
    *basic_vim_rules(LEFT, { "key_code": "left_arrow" }, extra_conditions=VIM_SUBMODES_OFF),
    *basic_vim_rules(RIGHT, { "key_code": "right_arrow" }, extra_conditions=VIM_SUBMODES_OFF),
    # these are just not that much easier than using arrows and holding option or command
    # *basic_vim_rules("f", { "key_code": "right_arrow", "modifiers": ["option"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("w", { "key_code": "right_arrow", "modifiers": ["option"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("b", { "key_code": "left_arrow", "modifiers": ["option"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("J", { "key_code": "down_arrow", "modifiers": ["option"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("K", { "key_code": "up_arrow", "modifiers": ["option"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("H", { "key_code": "left_arrow", "modifiers": ["left_command"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("L", { "key_code": "right_arrow", "modifiers": ["left_command"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("g", { "key_code": "up_arrow", "modifiers": ["left_command"] }, extra_conditions=VIM_SUBMODES_OFF),
    # *basic_vim_rules("G", { "key_code": "down_arrow", "modifiers": ["left_command"] }, extra_conditions=VIM_SUBMODES_OFF),
]

with open(os.path.realpath(__file__).replace('.py', '.json'), 'w') as f:
    json.dump({
        "title": "Jeff Wu's karabiner settings",
        "rules": [
            # {
            #     "description": "Mouse Mode",
            #     "manipulators": mouse_mode_rules,
            # },
            {
                "description": f"Vim Keys: Semicolon to enable",
                "manipulators": vim_keys_rules,
            },
            {
                "description": "Caps Lock to Control, Escape on single press.",
                "manipulators": caps_lock_rules,
            },
            # {
            #     "description": "Right Command to Escape.",
            #     "manipulators": right_command_rules,
            # },
            # {
            #     "description": "semicolon = arrows",
            #     "manipulators": arrow_rules,
            # },
            {
                "description": "Better Shifting: Parentheses on shift keys",
                "manipulators": shift_rules,
            },
            # {
            #     "description": f"Vim mode rules: hold {VIM_MODE_KEY} to enable",
            #     "manipulators": vim_keys_rules,
            # },
            {
                "description": "Change caps + space to backspace",
                "manipulators": [
                    basic_rule({
                        # use left control since we map caps to that
                        "from": single_key("spacebar", [ "left_control" ]),
                        "to": [ { "key_code": "delete_or_backspace" } ],
                    }),
                ]
            },
    ],
    }, f, indent=2)


