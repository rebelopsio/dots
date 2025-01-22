function awsp --description "Set up AWS profile with yawsso and region"
    argparse h/help -- $argv
    if set -ql _flag_help
        echo "Usage: awsp <profile-name> [region]"
        echo "Default region: us-east-1"
        return 0
    end

    if test (count $argv) -lt 1 -o (count $argv) -gt 2
        echo "Usage: awsp <profile-name> [region]"
        return 1
    end

    # Run yawsso first
    yawsso login --profile $argv[1]
    if test $status -ne 0
        echo "yawsso failed to run"
        return 1
    end

    # Set AWS_PROFILE
    set -gx AWS_PROFILE $argv[1]

    # Set AWS_REGION with proper argument checking
    if test (count $argv) -eq 2
        set -gx AWS_REGION $argv[2]
    else
        set -gx AWS_REGION us-east-1
    end

    echo "AWS Profile set to: $AWS_PROFILE"
    echo "AWS Region set to: $AWS_REGION"
end
