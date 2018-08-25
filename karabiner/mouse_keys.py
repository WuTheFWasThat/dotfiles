import os
import json

title = "Mouse Keys Mode"
description = "Mouse Keys Mode"

DOWN = "j"
UP = "k"
LEFT = "h"
RIGHT = "l"
MOUSE_MODE_KEY = "semicolon"
ARROW = "a"
SLOW = "s"
SCROLL = "d"
LEFT_CLICK = "f"
MIDDLE_CLICK = "v"
RIGHT_CLICK = "g"

SIMULTANEOUS_THRESHOLD_MS = 100
SIMULTANEOUS_THRESHOLD_MS_RULE = { "basic.simultaneous_threshold_milliseconds": SIMULTANEOUS_THRESHOLD_MS }

MOUSE_SCROLL_SPEED = 32
MOUSE_SPEED = 2048
MOUSE_SLOW_MULTIPLIER = 0.25

MOUSE_MODE = "mouse_keys_mode"
SCROLL_MODE = "mouse_keys_mode_scroll"
ARROW_MODE = "mouse_keys_mode_arrows"

def var_is_set(var, value=1):
    """ Returns condition that variable is set. """
    return {
        "type": "variable_if",
        "name": var,
        "value": value
    }

def set_var(var, value=1):
    """ Returns condition that variable is set. """
    return {
        "set_variable": {
            "name": var,
            "value": value
        }
    }

def single_key(key_code):
    return {
        "key_code": key_code,
        "modifiers": {
            "optional": [
                "any"
            ]
        }
    }

def simultaneous_keys(key_codes):
    return {
        "simultaneous": [
            { "key_code": key_code } for key_code in key_codes
        ],
        "simultaneous_options": {
            "key_down_order": "strict",
            "key_up_order": "strict_inverse",
            "to_after_key_up": [
                set_var(MOUSE_MODE, 0),
                set_var(SCROLL_MODE, 0),
                set_var(ARROW_MODE, 0),
            ]
        },
        "modifiers": { "optional": [ "any" ] }
    }

def basic_rule(items):
    return {
        "type": "basic",
        **items
    }

rules = [
    basic_rule({
      "from": single_key(DOWN),
      "to": [
        { "mouse_key": { "vertical_wheel": 32 } }
      ],
      "conditions": [
        var_is_set("mouse_keys_mode"),
        var_is_set("mouse_keys_mode_scroll"),
      ]
    }),
    basic_rule({
      "from": single_key(DOWN),
      "to": [
        { "key_code": "down_arrow" }
      ],
      "conditions": [
        var_is_set("mouse_keys_mode"),
        var_is_set("mouse_keys_mode_arrows"),
      ]
    }),
    basic_rule({
      "from": single_key(DOWN),
      "to": [
        { "mouse_key": { "y": 2048 } }
      ],
      "conditions": [
        var_is_set("mouse_keys_mode"),
      ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, DOWN]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "mouse_key": { "y": MOUSE_SPEED } }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(UP),
        "to": [
            { "mouse_key": { "vertical_wheel": -MOUSE_SCROLL_SPEED } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
            var_is_set("mouse_keys_mode_scroll"),
        ]
    }),
    basic_rule({
        "from": single_key(UP),
        "to": [
            { "key_code": "up_arrow" }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
            var_is_set("mouse_keys_mode_arrows"),
        ]
    }),
    basic_rule({
        "from": single_key(UP),
        "to": [
            { "mouse_key": { "y": -MOUSE_SPEED } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, UP]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "mouse_key": { "y": -MOUSE_SPEED } }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(LEFT),
        "to": [
            { "mouse_key": { "horizontal_wheel": MOUSE_SCROLL_SPEED } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
            var_is_set("mouse_keys_mode_scroll"),
        ]
    }),
    basic_rule({
        "from": single_key(LEFT),
        "to": [
            { "key_code": "left_arrow" }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
            var_is_set("mouse_keys_mode_arrows"),
        ]
    }),
    basic_rule({
        "from": single_key(LEFT),
        "to": [
            { "mouse_key": { "x": -MOUSE_SPEED } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, LEFT]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "mouse_key": { "x": -MOUSE_SPEED } }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(RIGHT),
        "to": [
            { "mouse_key": { "horizontal_wheel": -MOUSE_SCROLL_SPEED } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
            var_is_set("mouse_keys_mode_scroll"),
        ]
    }),
    basic_rule({
        "from": single_key(RIGHT),
        "to": [
            { "key_code": "right_arrow" }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
            var_is_set("mouse_keys_mode_arrows"),
        ]
    }),
    basic_rule({
        "from": single_key(RIGHT),
        "to": [
            { "mouse_key": { "x": MOUSE_SPEED } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, RIGHT]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "mouse_key": { "x": MOUSE_SPEED } }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(LEFT_CLICK),
        "to": [
            { "pointing_button": "button1" }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, LEFT_CLICK]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "pointing_button": "button1" }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(MIDDLE_CLICK),
        "to": [
            { "pointing_button": "button3" }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, MIDDLE_CLICK]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "pointing_button": "button3" }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(RIGHT_CLICK),
        "to": [
            { "pointing_button": "button2" }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, RIGHT_CLICK]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "pointing_button": "button2" }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(SCROLL),
        "to": [
            set_var("mouse_keys_mode_scroll", 1),
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ],
        "to_after_key_up": [
            set_var("mouse_keys_mode_scroll", 0),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, SCROLL]),
        "to": [
            set_var("mouse_keys_mode", 1),
            set_var("mouse_keys_mode_scroll", 1),
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE,
        "to_after_key_up": [
            set_var("mouse_keys_mode_scroll", 0),
        ]
    }),
    basic_rule({
        "from": single_key(SLOW),
        "to": [
            { "mouse_key": { "speed_multiplier": MOUSE_SLOW_MULTIPLIER } }
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, SLOW]),
        "to": [
            set_var("mouse_keys_mode", 1),
            { "mouse_key": { "speed_multiplier": MOUSE_SLOW_MULTIPLIER } }
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE
    }),
    basic_rule({
        "from": single_key(ARROW),
        "to": [
            set_var("mouse_keys_mode_arrows", 1),
        ],
        "conditions": [
            var_is_set("mouse_keys_mode"),
        ],
        "to_after_key_up": [
            set_var("mouse_keys_mode_arrows", 0),
        ]
    }),
    basic_rule({
        "from": simultaneous_keys([MOUSE_MODE_KEY, ARROW]),
        "to": [
            set_var("mouse_keys_mode", 1),
            set_var("mouse_keys_mode_arrows", 1),
        ],
        "parameters": SIMULTANEOUS_THRESHOLD_MS_RULE,
        "to_after_key_up": [
            set_var("mouse_keys_mode_scroll", 0),
        ]
    })
]
with open(os.path.realpath(__file__).replace('.py', '.json'), 'w') as f:
    json.dump({
      "title": title,
      "rules": [ {
        "description": description,
        "manipulators": rules,
      } ],
    }, f, indent=2)
