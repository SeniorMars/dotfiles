complete -c flamegraph -s p -l pid -d 'Profile a running process by pid' -r
complete -c flamegraph -l completions -d 'Generate shell completions for the given shell' -r -f -a "{bash	'',elvish	'',fish	'',powershell	'',zsh	''}"
complete -c flamegraph -s o -l output -d 'Output file' -r -F
complete -c flamegraph -l root -d 'Run with root privileges (using `sudo`). Accepts an optional argument containing command line options which will be passed to sudo' -r
complete -c flamegraph -s F -l freq -d 'Sampling frequency' -r
complete -c flamegraph -s c -l cmd -d 'Custom command for invoking perf/dtrace' -r
complete -c flamegraph -l notes -d 'Set embedded notes in SVG' -r
complete -c flamegraph -l min-width -d 'Omit functions smaller than <FLOAT> pixels' -r
complete -c flamegraph -l image-width -d 'Image width in pixels' -r
complete -c flamegraph -l palette -d 'Color palette' -r -f -a "{aqua	'',blue	'',green	'',hot	'',io	'',java	'',js	'',mem	'',orange	'',perl	'',python	'',purple	'',red	'',rust	'',wakeup	'',yellow	''}"
complete -c flamegraph -l post-process -d 'Run a command to process the folded stacks, taking the input from stdin and outputting to stdout' -r
complete -c flamegraph -l perfdata -r -F
complete -c flamegraph -s v -l verbose -d 'Print extra output to help debug problems'
complete -c flamegraph -l open -d 'Open the output .svg file with default program'
complete -c flamegraph -l deterministic -d 'Colors are selected such that the color of a function does not change between runs'
complete -c flamegraph -s i -l inverted -d 'Plot the flame graph up-side-down'
complete -c flamegraph -l reverse -d 'Generate stack-reversed flame graph'
complete -c flamegraph -l flamechart -d 'Produce a flame chart (sort by time, do not merge stacks)'
complete -c flamegraph -l ignore-status -d 'Ignores perf\'s exit code'
complete -c flamegraph -l no-inline -d 'Disable inlining for perf script because of performance issues'
complete -c flamegraph -s h -l help -d 'Print help'
complete -c flamegraph -s V -l version -d 'Print version'
