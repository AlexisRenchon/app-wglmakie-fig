using JSServe
JSServe.Server(App(DOM.div("hello world")), "0.0.0.0", parse(Int,ARGS[1]), wait(server))
