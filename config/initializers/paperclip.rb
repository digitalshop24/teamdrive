Paperclip::Attachment.default_options.update(
  styles: { big: "1000x1000>", medium: "300x300>", thumb: "100x100>" },
  storage: :s3,
  path: "/:class/:attachment/:id_partition/:style/:filename",
  s3_host_name: "s3-eu-central-1.amazonaws.com",
  url: ":s3_domain_url",
  s3_credentials: {
    bucket: 'teamdrived24shop',
    access_key_id: 'AKIAJJJDDIL2ICSKTYTA',
    secret_access_key: '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'
  }
)
