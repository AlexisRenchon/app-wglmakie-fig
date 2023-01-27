using JSServe
using WGLMakie 

function demo()
        fig = Figure()
        ax = Axis(fig[1, 1])
        sg = SliderGrid(
            fig[1, 2],
            (label = "Voltage", range = 0:0.1:10, format = "{:.1f}V", startvalue = 5.3),
            (label = "Current", range = 0:0.1:20, format = "{:.1f}A", startvalue = 10.2),
            (label = "Resistance", range = 0:0.1:30, format = "{:.1f}Ω", startvalue = 15.9),
            width = 350,
            tellheight = false)
        sliderobservables = [s.value for s in sg.sliders]
        bars = lift(sliderobservables...) do slvalues...
                [slvalues...]
        end
        WGLMakie.barplot!(ax, bars, color = [:yellow, :orange, :red])
        ylims!(ax, 0, 30)
        fig
        return fig
end

my_app = App() do session::Session  
    fig = demo()
    return DOM.div(fig) 
end

#app_name = get(ENV, "HEROKU_APP_NAME", "jsserve-app-test")
#url = "https://$(app_name).herokuapp.com"
#server = JSServe.Server(my_app, "0.0.0.0", parse(Int, ENV["PORT"]))
#server.proxy_url = url

#wait(server)
