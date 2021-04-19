FROM node:14

RUN apt-get update

# for https
RUN apt-get install -yyq ca-certificates

# install libraries
RUN apt-get install -yyq libappindicator1 libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6

# tools
RUN apt-get install -yyq gconf-service lsb-release wget xdg-utils

# and fonts
RUN apt-get install -yyq fonts-liberation

# RUN npm install yarn -g

# Setting working directory. All the path will be relative to WORKDIR
WORKDIR /usr/src/app
# Installing dependencies
RUN npm install typescript -g
RUN mkdir modules && cd modules && mkdir api && mkdir app && mkdir bull && mkdir creatives && mkdir domain  && mkdir gcp
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install xorg xvfb gtk2-engines-pixbuf --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install imagemagick x11-apps --no-install-recommends
# Install x11vnc.
RUN apt-get install -y x11vnc
# Install xvfb.
RUN apt-get install -y xvfb
# Install fluxbox.
RUN apt-get install -y fluxbox
# Install wget.
RUN apt-get install -y wget
# Install wmctrl.
RUN apt-get install -y wmctrl
# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install gconf-service libasound2 libatk1.0-0 libatk-bridge2.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libgbm-dev
ENV CHROMIUM_FLAGS=--enable-gpu-rasterization,--enable-hardware-overlays,--enforce-vulkan-protected-memory,--use-vulkan 
ENV USE_GL=desktop
RUN Xvfb xvfb :1 & Xvfb :10 -ac & export DISPLAY=:10
RUN DEBIAN_FRONTEND=noninteractive apt-get install xserver-xorg-core -y
RUN apt-get install neofetch -y

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "node", "index.js" ]