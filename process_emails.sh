# process_emails.sh
#!/bin/bash
maildir="/var/mail/vmail"
endpoint="http://your.endpoint.url"

for mailfile in "$maildir/new/"*; do
  if [ -f "$mailfile" ]; then
    # Send the email to the HTTP endpoint
    # curl -X POST -F "file=@$mailfile" $endpoint
    # For now we'll just print the email to the console
    cat "$mailfile"

    # Move the processed file to the 'cur' directory to avoid reprocessing
    mv "$mailfile" "${mailfile/new/cur}"
  fi
done
