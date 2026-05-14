aws_tokens=$(aws configure export-credentials --format env)
encrypted_tokens=$(echo "$aws_tokens" | iactl secrets encrypt)

to_copy="eval \$(echo \"$encrypted_tokens\" | iactl secrets decrypt)"
xclip -selection clipboard -in <<< "$to_copy"
