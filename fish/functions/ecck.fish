function ecck --wraps='ssh -i ~/.ssh/CKKey.pem ubuntu@ec2-52-215-115-238.eu-west-1.compute.amazonaws.com --save' --wraps='ssh -i ~/.ssh/CKKey.pem ubuntu@ec2-52-215-115-238.eu-west-1.compute.amazonaws.com' --description 'alias ecck=ssh -i ~/.ssh/CKKey.pem ubuntu@ec2-52-215-115-238.eu-west-1.compute.amazonaws.com'
  ssh -i ~/.ssh/CKKey.pem ubuntu@ec2-52-215-115-238.eu-west-1.compute.amazonaws.com $argv
        
end
