require "aes"

encrypted_file = ARGV[0]
password = ARGV[1]

decrypted_text = AES.decrypt(File.read(encrypted_file), password)

new_file = "#{encrypted_file[0..-4]}"

File.open(new_file, "wb") { |f| f.write(decrypted_text) }
