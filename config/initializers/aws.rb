Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})
S3 = Aws::S3::Resource.new(region: 'us-east-1')
S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET_NAME'])

# Aws.config.update({
#   region: 'us-east-1',
#   credentials: Aws::Credentials.new('AKIAI26BCWD2GHCFV4JA', 'ue3k0dvJPGHOMWW8Hs2OVbnR4hFEqesMjNqYS5/d'),
# })
# S3 = Aws::S3::Resource.new(region: 'us-east-1')
# S3_BUCKET = Aws::S3::Resource.new.bucket('phone-app')
