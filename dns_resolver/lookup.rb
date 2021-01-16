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
  :A => [{}, {}],
  :CNAME => [{}, {}]
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

  # get unique record types
  types = column_data.map { |row| row[0] }.uniq

  types.map do |type|
    # array of recs of a single type
    type_recs = {}

    column_data.each do |row|
      if row[0] == type
        type_recs[row[1].to_sym] = row[2].to_sym
      end
    end
    # store all the sub hashes in two main type hash :A and :CNAME
    dns_rec[type.to_sym] = type_recs
  end
  # return the dns record (hash)
  dns_rec
end

def resolve(dns_records, lookup_chain, domain)
  # get the types again!
  types = dns_records.keys

  domain_info = {}
  type_info = ""

  types.map do |type_key|
    # search record for more info about domain
    domain_info = dns_records[type_key].select { |key, value| key.to_s == domain }

    if !domain_info.empty?
      domain_info[:type] = type_key
      break
    end
  end

  # if domain_info is still empty
  if domain_info.empty?
    lookup_chain = ["Error: record not found for #{domain}"]
  else
    # if the record is of type A
    if domain_info[:type].to_s == "A"
      # got the IP Address, push the domain and IP to lookup_chain
      lookup_chain.push(domain_info.keys[0])
      lookup_chain.push(domain_info[domain.to_sym])
      # if type CNAME
    else
      if (lookup_chain.last != domain)
        lookup_chain.push(domain)
      end
      resolve(dns_records, lookup_chain, domain_info[domain.to_sym].to_s)
    end
  end
  lookup_chain
end

# ..
# ..

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
