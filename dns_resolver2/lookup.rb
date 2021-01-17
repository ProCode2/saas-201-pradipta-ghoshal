def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

=begin
record = {
  domain => { :type => "", :tartget => ""},
  domain => { :type => "", :tartget => ""},
}
=end
def parse_dns(raw)
  column_data = []
  dns_rec = {}

  # removing lines starting with # and empty lines with filter
  lines = raw.filter { |line| line.length > 1 and line[0] != "#" }

  # breaking lines into words and storing in column data
  lines.map do |line|
    column_data.push(line.split(",").map { |word| word.strip() })
  end

  # return the hash
  column_data.inject({}) do |memo, row|
    memo[row[1]] = {
      :type => row[0],
      :target => row[2],
    }
    memo
  end
end

def resolve(dns_records, lookup_chain, domain)
  # try to fetch domain data from our record
  domain_info = dns_records[domain]

  # if record of this domain does not exist
  if !domain_info
    return ["Error: Record not found for #{domain}"]
    # if record does exist
  elsif domain_info[:type] == "CNAME"
    if domain != lookup_chain.last
      lookup_chain << domain
    end
    resolve(dns_records, lookup_chain, domain_info[:target])
  elsif domain_info[:type] == "A"
    if domain != lookup_chain.last
      lookup_chain << domain
    end
    lookup_chain << domain_info[:target]
  else
    return ["Invalid record type for #{domain}"]
  end
  return lookup_chain
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
