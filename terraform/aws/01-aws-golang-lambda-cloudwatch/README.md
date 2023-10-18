## AWS + Golang + Lambda + CloudWatch

## Infrastructure

### 1. AWS
1.1 IAM Role
1.2 IAM Policy

### 2. Golang
2.1 Test Project which takes name as input and prints `Hello {name}!`

### 3. Lambda
3.1 Lambda funciton setup with function URL with `NONE` authentication

### 4. CloudWatch
4.1 Log Group: For dropping lambda execution logs

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
lambda_function_url = "https://tphseoryxehbxtrhb4x5ccwglq0xvvtv.lambda-url.ap-south-1.on.aws/"
```

## Test
`Note`: Copy the `lambda_function_url` from your output and substitute it with `{lambda_function_url}` in following commands

- `curl {lambda_function_url}`
