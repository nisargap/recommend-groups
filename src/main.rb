# Author: Nisarga Patel
require 'csv'
require 'set'

group_data = CSV.read("../data/groups.csv", :encoding => 'windows-1251:utf-8')

$stud_group_map = Hash.new("some descriptive string")

$group_stud_map = Hash.new("some descriptive string")

$recom_group_map = Hash.new("some descriptive string")

$freq_of_groups = Hash.new("some descriptive string")

$freq_report_per = Hash.new("some descriptive string")

$set_of_groups = Set.new


for element in group_data

	if !$stud_group_map.key?(element[1])

		$stud_group_map[element[1]] = Set.new

	end

	if !$group_stud_map.key?(element[0])

		$group_stud_map[element[0]] = Set.new
		$recom_group_map[element[0]] = Set.new
		$freq_of_groups[element[0]] = 0
		$freq_report_per[element[0]] = Hash.new("some descriptive string")
	end

	$stud_group_map[element[1]].add(element[0])
	$group_stud_map[element[0]].add(element[1])
	$freq_of_groups[element[0]] += 1
	$set_of_groups.add(element[0])

end

for group in $set_of_groups

	int_of_group = Set.new []

	for student in $group_stud_map[group]

		

		for sub_group in $stud_group_map[student]

			if !$freq_report_per[group].key?(sub_group)
				$freq_report_per[group][sub_group] = 0
			end
				$freq_report_per[group][sub_group] += 1

		end

		# figure out the groups the student is in and merge
		
	end

	# $recom_group_map[group] = int_of_group

end

def get_num_mems(key)

	return $group_stud_map[key].length()
end

def get_freq_report(key)

	arr = Hash.new
	$freq_report_per[key].sort_by {|k,v| v}.reverse.each do |key, value|
		arr[key] = value
	end
	return arr
end

def print_freq_report(key)

	$freq_report_per[key].sort_by {|k,v| v}.reverse.each do |key, value|
		puts key 
		puts value
	end

end

ht1 = get_freq_report("UMBC Musician's Corner")
ht2 = get_freq_report("Musical Theatre Club")

ht1.each do |k,v|

	if ht2.key?(k)
		if (ht1[k] - ht2[k]).abs < 10
			puts k
			puts ht1[k]
			puts ht2[k]
		end
	end

end

# CSV.open("data.csv", "wb") {|csv| $freq_of_groups.to_a.each {|elem| csv << elem} }