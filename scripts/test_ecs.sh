# Test ECS by building a Next.js app and deploying to the ECR, letting ECS pull the image and run it

# Authenticate Docker to ECR
echo "Authenticating Docker to ECR"
account_id=$(aws sts get-caller-identity --query "Account" --output text)
region="us-east-1"
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.$region.amazonaws.com
if [ $? -ne 0 ]; then
    echo "Failed to authenticate Docker to ECR"
    exit 1
fi

# Get the names of each directory in ./deployments
dirs=$(find ./deployments -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

# let user select an environment
select dir in $dirs; do
    if [ -n "$dir" ]; then
        break
    else
        echo "Invalid selection"
    fi
done

project_name="module-demo-$dir"

# Build the Next.js app
# this is stored in containers/demo
echo "Building Next.js app"
docker build -t "demo-$dir-main" containers/demo

# Get the ECR repository URI
repository_uri=$(aws ecr describe-repositories --region $region --repository-names $project_name --query "repositories[0].repositoryUri" --output text)
echo "ECR repository URI: $repository_uri"

# Push the image to ECR
echo "Pushing image to ECR"
docker tag "demo-$dir-main" $repository_uri
docker push $repository_uri

# Update the cluster service to use the new image
echo "Updating ECS service"
aws ecs update-service --region $region --cluster $project_name --service $project_name --force-new-deployment --no-cli-pager
if [ $? -ne 0 ]; then
    echo "Failed to update ECS service"
    exit 1
fi

echo "Script completed successfully"