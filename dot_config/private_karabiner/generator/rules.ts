import fs from "fs";
import { KarabinerRules } from "./types";
import {
    createHyperSubLayers,
    asp,
    app,
    open,
    rectangle,
    shell,
} from "./utils";

// const yabai = "/opt/homebrew/bin/yabai"

const rules: KarabinerRules[] = [
    // Define the Hyper key itself
    {
        description: "Hyper Key (⌃⌥⇧⌘)",
        manipulators: [
            {
                description: "Caps Lock -> Hyper Key",
                from: {
                    key_code: "caps_lock",
                    modifiers: {
                        optional: ["any"],
                    },
                },
                to: [
                    {
                        set_variable: {
                            name: "hyper",
                            value: 1,
                        },
                    },
                ],
                to_after_key_up: [
                    {
                        set_variable: {
                            name: "hyper",
                            value: 0,
                        },
                    },
                ],
                to_if_alone: [
                    {
                        key_code: "escape",
                    },
                ],
                type: "basic",
            },
            {
                description: "Meh -> Hyper Key",
                from: {
                    simultaneous: [
                        { key_code: "left_control" },
                        { key_code: "left_shift" },
                        { key_code: "left_alt" },
                    ],
                },
                to: [
                    {
                        set_variable: {
                            name: "hyper",
                            value: 1,
                        },
                    },
                ],
                to_after_key_up: [
                    {
                        set_variable: {
                            name: "hyper",
                            value: 0,
                        },
                    },
                ],
                type: "basic",
            },
            {
                type: "basic",
                description: "Disable CMD + Tab to force Hyper Key usage",
                from: {
                    key_code: "tab",
                    modifiers: {
                        mandatory: ["left_command"],
                    },
                },
                to: [
                    {
                        key_code: "tab",
                    },
                ],
            },
        ],
    },
    ...createHyperSubLayers({
        // o = "Open" applications
        o: {
            v: shell`open -na Ghostty.app --args --macos-icon=blueprint --window-inherit-working-directory -e /usr/local/bin/zshi /opt/homebrew/bin/nvim`,
            t: open("raycast://extensions/raycast/translator/translate"),
            g: app("Ghostty"),
            b: app("Helium"),
            i: app("Messages"),
            l: app("Linear"),
            c: app("Calendar"),
            s: app("Spotify"),
            m: shell`open -na Ghostty.app --args --macos-icon=blueprint --window-inherit-working-directory -e /Users/ashtynmorel-blake/.cargo/bin/spotify_player`,
            n: open("Obsidian"),
            e: shell`open -a Emacs`,
        },
        // Ashtyn stuff
        a: {
            c: open("raycast://extensions/mblode/quick-event/index"),
            t: shell`open -a Ashtyns\\ Own\\ Timer`,
        },
        n: {
            s: shell`open raycast://extensions/raycast/raycast-notes/search-notes && open -a raycast`,
            c: open("raycast://extensions/raycast/raycast-notes/create-note"),
            a: open("raycast://extensions/raycast/raycast-notes/ask-raycast-notes"),
        },
        s: {
            u: open("raycast://extensions/raycast/system/turn-volume-down"),
            i: open("raycast://extensions/raycast/system/turn-volume-up"),
            r: open(
                "raycast://extensions/pradeepb28/quicktime/start-screen-recording",
            ),
        },
        // music
        m: {
            n: open("raycast://extensions/mattisssa/spotify-player/next"),
            b: open("raycast://extensions/mattisssa/spotify-player/previous"),
            c: open("raycast://extensions/mattisssa/spotify-player/nowPlaying"),
            p: open("raycast://extensions/mattisssa/spotify-player/togglePlayPause"),
            l: open("raycast://extensions/mattisssa/spotify-player/yourLibrary"),
            s: open("raycast://extensions/mattisssa/spotify-player/toggleShuffle"),
            f: open("raycast://extensions/mattisssa/spotify-player/search"),
        },
        l: {
            d: {
                description: "general developer layout",
                to: [
                    {
                        key_code: "d",
                        modifiers: ["right_command"],
                    },
                ],
            },
            m: {
                description: "Money Company dev layout",
                to: [
                    {
                        key_code: "t",
                        modifiers: ["right_command"],
                    },
                ],
            },
        },
        r: {
            h: rectangle("left-half"),
            l: rectangle("right-half"),
            k: rectangle("top-half"),
            j: rectangle("bottom-half"),
            c: rectangle("center"),
            m: rectangle("maximize"),
        },
        // w = "Window" via rectangle.app
        w: {
            c: rectangle("center"),
            //
            // // o: asp("focus-monitor right"),
            // // y: asp("focus-monitor left"),
            //
            // k_shift: asp("move up"),
            // j_shift: asp("move down"),
            // h_shift: asp("move left"),
            // l_shift: asp("move right"),
            //
            // k: asp("focus up"),
            // j: asp("focus down"),
            // h: asp("focus left"),
            // l: asp("focus right"),
            //
            // equal_sign: asp("balance-sizes"),
            spacebar: asp("layout floating tiling"),
            //
            m: asp("fullscreen"),
            // "t": asp("resize smart +50"),
            // "s": asp("resize smart -50"),
            r: shell`open -g raycast://extensions/raycast/window-management/reasonable-size`,
            f: open("raycast://extensions/raycast/navigation/switch-windows"),
            "y": asp("workspace Code"),
            "u": asp("workspace Browser"),
            "i": asp("workspace Terminal"),
            "o": asp("workspace Other"),

            "y_shift": asp("move-node-to-workspace Code"),
            "u_shift": asp("move-node-to-workspace Browser"),
            "i_shift": asp("move-node-to-workspace Terminal"),
            "o_shift": asp("move-node-to-workspace Other"),
            hyphen: asp("resize smart -50"),
            equal_sign: asp("resize smart +50"),

            h: asp("focus left"),
            l: asp("focus right"),
            j: asp("focus down"),
            k: asp("focus up"),

            h_shift: asp("move left"),
            l_shift: asp("move right"),
            j_shift: asp("move down"),
            k_shift: asp("move up"),
        },
    }),
];

fs.writeFileSync(
    "../karabiner.json",
    JSON.stringify(
        {
            global: {
                show_in_menu_bar: false,
            },
            profiles: [
                {
                    name: "Default",
                    complex_modifications: {
                        rules,
                    },
                },
            ],
        },
        null,
        2,
    ),
);
