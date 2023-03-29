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
SLOW = "s"
SCROLL = "d"
LEFT_CLICK = "f"
MIDDLE_CLICK = "v"
RIGHT_CLICK = "g"
LEFT_CLICK_2 = "u"
MIDDLE_CLICK_2 = "i"
RIGHT_CLICK_2 = "o"

MOUSE_SCROLL_SPEED = 32
MOUSE_SPEED = 1200
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

def simultaneous_keys(key_codes, after_up=None):
    res = {
        "simultaneous": [
            { "key_code": key_code } for key_code in key_codes
        ],
        "simultaneous_options": {
            "key_down_order": "strict",
            "key_up_order": "strict_inverse",
        },
        "modifiers": { "optional": [ "any" ] }
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


def _scroll_combos(key):
    return [
        single_key(key, [ "left_shift" ]),
        single_key(key, [ "right_shift" ]),
        simultaneous_keys([SCROLL, key]),
    ]

# def _toggle_combos():
#     return [
#         single_key(ACTIVATE_TOGGLE, ["left_command"]),
#         single_key(ACTIVATE_TOGGLE, ["right_command"]),
#         simultaneous_keys([VIM_MODE_KEY, ACTIVATE_TOGGLE]),
#         # DONT KNOW WHY THIS DOESNT WORK
#         simultaneous_keys(["escape", ACTIVATE_TOGGLE]),
#     ]

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

VIM_KEYS_MOUSE_MODE = "vim_keys_mouse_mode"
VIM_KEYS_SCROLL_MODE = "vim_keys_mode_scroll"
VIM_KEYS_ARROW_MODE = "vim_keys_mode_arrows"

VIM_KEYS_AFTER_UP = [
    set_var(VIM_KEYS_MOUSE_MODE, 0),
    set_var(VIM_KEYS_SCROLL_MODE, 0),
    set_var(VIM_KEYS_ARROW_MODE, 0),
]

def basic_vim_rule(key, to, modifiers=(), extra_conditions=()):
    return basic_rule({
        "from": single_key(key, modifiers=modifiers),
        "to": [to],
        "conditions": [
            var_is_set(VIM_KEYS_MOUSE_MODE),
        ] + list(extra_conditions)
    })

def vim_submode_rules(key, mode):
    return [
        basic_rule({
            "from": single_key(key),
            "to": [
                set_var(mode, 1),
            ],
            "conditions": [
                var_is_set(VIM_KEYS_MOUSE_MODE),
            ],
            "to_after_key_up": [
                set_var(mode, 0),
            ]
        }),
        basic_rule({
            "from": simultaneous_keys([VIM_MODE_KEY, key], after_up=VIM_KEYS_AFTER_UP),
            "to": [
                set_var(VIM_KEYS_MOUSE_MODE, 1),
                set_var(mode, 1),
            ],
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE,
        }),
    ]

def vim_scroll_rules(key, to, modifiers=()):
    return [
        basic_vim_rule(key, to, extra_conditions=[var_is_set(VIM_KEYS_SCROLL_MODE)]),
        basic_rule({
            "from": simultaneous_keys([VIM_MODE_KEY, SCROLL, DOWN], after_up=VIM_KEYS_AFTER_UP),
            "to": [
                set_var(VIM_KEYS_MOUSE_MODE, 1),
                set_var(VIM_KEYS_SCROLL_MODE, 1),
                to,
            ],
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
        }),
    ]

def vim_mouse_rules(key, to, modifiers=()):
    return [
        # TODO: extra condition here
        basic_vim_rule(key, to),
        basic_rule({
            # TODO extra key here
            "from": simultaneous_keys([VIM_MODE_KEY, key], after_up=VIM_KEYS_AFTER_UP),
            "to": [
                set_var(VIM_KEYS_MOUSE_MODE, 1),
                # TODO extra mode here
                to
            ],
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
        }),
    ]

def vim_combo_rules(key, to):
    # TODO support modifiers?
    return [
        basic_rule({
            "from": single_key(key),
            "to": [ to ],
            "conditions": [
                var_is_set(VIM_KEYS_MOUSE_MODE),
            ]
        }),
        basic_rule({
            "from": simultaneous_keys([VIM_MODE_KEY, key], after_up=VIM_KEYS_AFTER_UP),
            "to": [set_var(VIM_KEYS_MOUSE_MODE, 1), to],
            "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
        }),
    ]

vim_keys_rules = [
    *vim_submode_rules(SCROLL, VIM_KEYS_SCROLL_MODE),
    *vim_scroll_rules(DOWN, { "mouse_key": { "vertical_wheel": MOUSE_SCROLL_SPEED }}),
    *vim_scroll_rules(UP, { "mouse_key": { "vertical_wheel": -MOUSE_SCROLL_SPEED }}),
    *vim_scroll_rules(LEFT, { "mouse_key": { "horizontal_wheel": MOUSE_SCROLL_SPEED }}),
    *vim_scroll_rules(RIGHT, { "mouse_key": { "horizontal_wheel": -MOUSE_SCROLL_SPEED }}),
    # *vim_submode_rules(ARROW, VIM_KEYS_ARROW_MODE),
    # basic_vim_rule(DOWN, { "key_code": "down_arrow" }),
    # basic_vim_rule(UP, { "key_code": "up_arrow" }),
    # basic_vim_rule(LEFT, { "key_code": "left_arrow" }),
    # basic_vim_rule(RIGHT, { "key_code": "right_arrow" }),
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
    *vim_combo_rules(FAST, { "mouse_key": { "speed_multiplier": MOUSE_FAST_MULTIPLIER } }),
    *vim_combo_rules(SLOW, { "mouse_key": { "speed_multiplier": MOUSE_SLOW_MULTIPLIER } }),
]

# VIM_MODE_KEY = "return_or_enter"
# VIM_KEYS_MODE = "vim_keys_mode"
# VIM_KEYS_AFTER_UP = [
#     set_var(VIM_KEYS_MODE, 0),
# ]

# def make_vim_keys_rules(key, to):
#     if key.upper() == key:
#         from_modifiers = ["left_shift", "right_shift"]
#         key = key.lower()
#     else:
#         from_modifiers = []
#     return [
#         basic_rule({
#             "from": single_key(key, modifiers=from_modifiers),
#             "to": to,
#             "conditions": [
#                 var_is_set(VIM_KEYS_MODE),
#             ]
#         }),
#         basic_rule({
#             "from": simultaneous_keys([VIM_MODE_KEY, key], after_up=VIM_KEYS_AFTER_UP),
#             "to": [
#                 set_var(VIM_KEYS_MODE, 1),
#             ],
#             "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
#         }),
#     ]

# vim_keys_rules = [
#     *make_vim_keys_rules("j", [ { "key_code": "down_arrow" } ]),
#     *make_vim_keys_rules("k", [ { "key_code": "up_arrow" } ]),
#     *make_vim_keys_rules("h", [ { "key_code": "left_arrow" } ]),
#     *make_vim_keys_rules("l", [ { "key_code": "right_arrow" } ]),
#     *make_vim_keys_rules("f", [ { "key_code": "right_arrow", "modifiers": ["option"] } ]),
#     *make_vim_keys_rules("w", [ { "key_code": "right_arrow", "modifiers": ["option"] } ]),
#     *make_vim_keys_rules("b", [ { "key_code": "left_arrow", "modifiers": ["option"] } ]),
#     *make_vim_keys_rules("J", [ { "key_code": "down_arrow", "modifiers": ["option"] } ]),
#     *make_vim_keys_rules("K", [ { "key_code": "up_arrow", "modifiers": ["option"] } ]),
#     *make_vim_keys_rules("H", [ { "key_code": "left_arrow", "modifiers": ["left_command"] } ]),
#     *make_vim_keys_rules("L", [ { "key_code": "right_arrow", "modifiers": ["left_command"] } ]),
#     *make_vim_keys_rules("g", [ { "key_code": "up_arrow", "modifiers": ["left_command"] } ]),
#     *make_vim_keys_rules("G", [ { "key_code": "down_arrow", "modifiers": ["left_command"] } ]),
# ]

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


