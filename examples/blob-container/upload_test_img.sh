# Assign input arguments to variables
AZURE_STORAGE_ACCOUNT=tfstoragetecla
AZURE_STORAGE_CONTAINER=test-images
FILE_PATH=./tito-lupa.png

# Extract the file name from the file path
FILE_NAME=$(basename "$FILE_PATH")

# Upload the image to the Azure Blob Storage container
az storage blob upload \
  --account-name "$AZURE_STORAGE_ACCOUNT" \
  --container-name "$AZURE_STORAGE_CONTAINER" \
  --name "$FILE_NAME" \
  --file "$FILE_PATH" \
  --overwrite

# Construct the public URL of the uploaded image
PUBLIC_URL="https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/$AZURE_STORAGE_CONTAINER/$FILE_NAME"

# Echo the public URL
echo "Image uploaded successfully. Public URL: $PUBLIC_URL"
