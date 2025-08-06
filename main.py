from open_deep_research.deep_researcher import deep_researcher

# The .as_asgi() method is the official way to expose a LangGraph graph
# as a standard web application for production servers.
app = deep_researcher.as_asgi()
