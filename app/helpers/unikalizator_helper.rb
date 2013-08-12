# coding: utf-8
module UnikalizatorHelper

  def self.unikalizator_do_action text

    #перемешать абзацы и перемешать предложения в пределах абзаца
    text = unik_mashup_paragraph_sentence text

    #Заменить русские буквы на эквиваленты
    #text = unik_replace_ruslat text, 100

    #Замена синоньемов
    text = unik_synonymizer_ru text
  end

  def self.unik_synonymizer_ru text, deph = 0
    words = text.split(' ')
    new_text = "";
    words.each do |word|
      if synonym = unik_get_synonym(word)
        new_text += ' '+synonym
      else
        new_text += ' '+word
      end
    end
    return new_text
  end

  def self.unik_get_synonym word
    if word =~ /[a-z]/
      capitaliz = false
    else
      capitaliz = true
    end

    syns = City.connection.select_all('SELECT syn FROM synonyms WHERE keyword="'+word.downcase+'" LIMIT 1')
    if syns.any?
      words = syns[0]['syn'].split(',')
      if capitaliz == true
        return words[rand(words.size)].capitalize!
      end
      return words[rand(words.size)];
    else
      return false;
    end
  end
  #выбираем замену
  def self.unik_replace_ruslat text ,level = 100
    words = text.split(' ')

    replace_count = (((words.size - 1) * level) / 100).round
    rand_keys = []
    k = 0;
    count = 0;
    words.size.times {rand_keys << k += 1 }
    rand_keys.shuffle!
    rand_keys.each do |rand_key|

      if rword = unik_ruslat(words[rand_key])
        words[rand_key] = rword;
        count += 1
      end

      if count >= replace_count
        break
      end
    end
    words.join(" ");
  end

  #замена
  def self.unik_ruslat word
    rus = 'аАеЕоОхХ';
    lat = 'aAeEoOxX';
    unless word.nil?
      word.tr(rus, lat)
    end

  end

  #перемешиватель
  def self.unik_mashup_paragraph_sentence text

    paragraphs = text.split(/\r|\n/) #получили абзацы в массив

    #перетусовываем массив абзацев
    paragraphs.shuffle!

    #перетусовываем предложения в пределах абзаца
    shuffle_paragraphs = Array.new
    it = 1;
    paragraphs.each do |paragraph|

      shuffle_paragraphs[it] = unik_mashup_sentence paragraph
      it += 1
    end

    shuffle_paragraphs.join('<br/>')
  end

  #обьединяем массив
  def self.unik_mashup_sentence text
    sentences = unik_split_sentence text
    sentences.shuffle!
    sentences.join('')
  end

  #Разбиваем абзац на массив строк
  def self.unik_split_sentence text
    text.gsub!(/\./,'.%e%')
    text.gsub!(/\!/,'!%e%')
    text.gsub!(/\?/,'?%e%')

    text.split('%e%')
  end
end