import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", help="The target config.xml file")
parser.add_argument("-p", "--parameter", help="The parameter name")
parser.add_argument("-v", "--value", help="The parameters value")
args = parser.parse_args()

if args.file and args.parameter and args.value:
    # first test the parameter isn't already there
    with open(args.file) as infile:
        for line in infile:
            if line.__contains__('<name>' + args.parameter + '</name>'):
                print "Param is already included"
                sys.exit(1)
    f = open(args.file, "r")
    contents = f.read()
    f.close()
    # find the location
    location = contents.find('<parameterDefinitions>')
    location += 22
    #create the insert block
    block = "\r\n"
    block += '        <hudson.model.StringParameterDefinition>'
    block += "\r\n"
    block += '          <name>' + args.parameter + '</name>'
    block += "\r\n"
    block += '          <description></description>'
    block += "\r\n"
    block += '          <defaultValue>' + args.value + '</defaultValue>'
    block += "\r\n"
    block += '          <trim>false</trim>'
    block += "\r\n"
    block += '        </hudson.model.StringParameterDefinition>'
    #insert it!
    new_contents = contents[:location] + block + contents[location:]
    #write out the new file
    f = open(args.file, "w")
    f.write(new_contents)
    f.close()

else:
    parser.print_help()
    sys.exit(1)

sys.exit(0)