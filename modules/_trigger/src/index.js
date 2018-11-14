const awsSdk = require('aws-sdk')

const ecs = new awsSdk.ECS()

const launchTask = async (name, args, env) => {
    console.log(`Launching task ${name}`)

    return await ecs.runTask({
        cluster: process.env.CLUSTER,
        taskDefinition: name,
        count: 1,
        launchType: 'FARGATE',
        networkConfiguration: {
            awsvpcConfiguration: {
                subnets: [
                    process.env.SUBNET
                ],
                assignPublicIp: 'ENABLED'
            }
        },
        overrides: {
            containerOverrides: [
                {
                    name: name.split(':')[0],

                    command: args,

                    environment: Object.entries(env).map(([name, value]) => {
                        return {
                            name: name.toString(),
                            value: value.toString()
                        }
                    })
                }
            ],

            taskRoleArn: process.env.TASK_ROLE_ARN,
            executionRoleArn: process.env.EXECUTION_ROLE_ARN
        }
    }).promise()
}

exports.handler = async (event) => {
    const { task_name, task_args, task_env } = event || {}

    await launchTask(task_name, task_args || [], task_env || {})
}
