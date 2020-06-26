# Configuration

## Docker commands and arguments
cmd bash 
bash stops if no terminal to connect to
so container shuts down

entrypoint
default command `sleep` then you can pass in parmas

format:
docker run ubuntu-sleeper 10
```dockerfile
FROM Ubuntu
ENTRYPOINT ["sleep"]
CMD ["5"]
```



