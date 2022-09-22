CUSSES = [
    'shit',
    'bitch',
    'fuck',
    'crap',
    'slut',
    'dick',
    'cock',
    'whore',
    'cocksuck',
    'asshole',
    'butt',
    'blowjob',
    'bastard',
    'vagina',
    'cunt',
    'douche',
    'dumb',
    'fag',
    'faggot',
    'jackass',
    'penis',
    'pussy',
    'damn'
    ]
    
PREFIXES = [
    'dumb',
    'mother'
    ]
    
POSTFIXES = [
    'ing',
    'er',
    'ed',
    's',
    'y',
    'ton',
    'es',
    'ty',
    'bag',
    'head',
    ]

String.class_eval do
    def indices(regex)
        instances = []
        self.scan(regex) do |match|
            instances << $~.offset(0)[0]
        end
        return instances
    end
end
    
def find_words(str)
    words = str.indices(/[\s]/)
    words.collect! {|w| w += 1}
    words.delete(-1)
    words << 0
    words << str.size + 1
    return words.uniq.sort
end

def find_cusses(str)    
    occurances = []
    CUSSES.each do |cuss|
        occurances += str.indices(/#{cuss}/)
    end
    return occurances.uniq.sort
end

def find_marks(str)
    marks = []
    words = find_words(str)
    cusses = find_cusses(str)
    cusses.each do |c|
        start = nil
        stop = nil
        words.each_index do |w|
            if words[w] <= c
                start = words[w]
                stop = words[w+1] - 2
            end
        end
        marks << [start, stop]
    end
    return marks
end

def markup(str)    
    marks = find_marks(str)
    new_str = str
    offset = 0
    marks.each do |s,e|
        # start
        start_tag = "<span class='cuss'>"
        new_str.insert(s + offset, start_tag)
        offset += start_tag.size
        #stop
        stop_tag = "</span>"
        new_str.insert(e + offset + 1, stop_tag)
        offset += stop_tag.size
    end
    return new_str
    
end
