## AWS + Golang + Lambda + Load Balancer

## Infrastructure

### 1. AWS
1.1 IAM Role
1.2 IAM Policy

### 2. Golang
2.1 Test Project which takes name as input and prints `Hello {name}!`

### 3. Lambda
3.1 Lambda funciton setup with function URL with `NONE` authentication

### 4. Load Balancer
4.1 For obtaining a fixed public URL.

## Pre-Requisite
It is assumed that `aws configure` command is already run and right credentials are already set in `~/.aws/credentials` config file.

## run
```
cd src && go build -o ../dist/main
cd ..
terraform init
terraform plan
terraform apply
```

## Output
```
load_balancer_url = "https://tphseoryxehbxtrhb4x5ccwglq0xvvtv.lambda-url.ap-south-1.on.aws/"
```

## Test
`Note`: Copy the `load_balancer_url` from your output and substitute it with `{load_balancer_url}` in following commands

- `curl {load_balancer_url}`
