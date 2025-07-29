# Method Call Graph

Thread-aware method-level call graph built using `MethodProxies` as the instrumentation backend. Calls from different threads are tracked separately.

All methods in the target application are instrumented. The tool records:

- Call frequency (number of times each method is invoked)
- Caller–callee relationships (who called who)
- Thread context (calls from other threads are identified and separated)

Each invocation updates the graph in real time. The final graph captures method interactions and execution counts across threads.

Licensed under the MIT License.

## How to install

```st
EpMonitor disableDuring: [
	Metacello new
		baseline: 'MethodCallGraph';
		repository: 'github://jordanmontt/method-call-graph:main';
		load ].
```

## Usage

```st
callGraphProfiler := CallGraphProfiler new.
callGraphProfiler packageNamesToInstrument:  { 'Microdown' . 'Microdown-RichTextComposer' }. "Set target packages to instrument"
callGraphProfiler profile: [ "Your application code here" ]
```