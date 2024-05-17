function mck --wraps='ssh -v -i "~/.ssh/ChargeKomplete.pem" -L 27019:docdb-2023-07-04-12-47-26.cquini0d1ggh.eu-west-1.docdb.amazonaws.com:27017 ubuntu@52.215.115.238 -N' --wraps='ssh -v -i "~/.ssh/CKKEy.pem" -L 27019:docdb-2023-07-04-12-47-26.cquini0d1ggh.eu-west-1.docdb.amazonaws.com:27017 ubuntu@52.215.115.238 -N' --description 'alias mck=ssh -v -i "~/.ssh/ChargeKomplete.pem" -L 27019:docdb-2023-07-04-12-47-26.cquini0d1ggh.eu-west-1.docdb.amazonaws.com:27017 ubuntu@52.215.115.238 -N'
  ssh -v -i "~/.ssh/ChargeKomplete.pem" -L 27019:docdb-2023-07-04-12-47-26.cquini0d1ggh.eu-west-1.docdb.amazonaws.com:27017 ubuntu@52.215.115.238 -N $argv
        
end
