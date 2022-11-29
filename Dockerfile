# pull the latest official nginx image
FROM nginx:stable

# run docker service on HTTPS
EXPOSE 80

# copy the additional nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# copy static maintanence
COPY . /usr/share/nginx/html/

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
