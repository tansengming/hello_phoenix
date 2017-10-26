FROM bitwalker/alpine-elixir-phoenix:latest

# Set exposed ports
EXPOSE 4000
# ENV PORT=5000 MIX_ENV=prod

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/package.json
RUN cd assets && npm install

ADD . ./

# Run frontend build, compile, and digest assets
# RUN cd assets && \
#     brunch build --production && \
#     mix do compile, phx.digest

USER default

ENTRYPOINT ["mix"]
CMD ["phx.server"]