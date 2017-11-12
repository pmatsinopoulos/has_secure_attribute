require 'spec_helper'

describe TestModelWithAttribute do
  it { expect(subject).to respond_to(:security_answer)               }
  it { expect(subject).to respond_to(:security_answer=)              }
  it { expect(subject).to respond_to(:security_answer_confirmation)  }
  it { expect(subject).to respond_to(:security_answer_confirmation=) }
  it { expect(subject).to respond_to(:authenticate_security_answer)  }

  it 'should confirm security answer' do
    subject.security_answer = 'hello there'
    subject.security_answer_confirmation = 'there hello'
    subject.valid?
    expect(subject.errors[:security_answer_confirmation]).to include("doesn't match Security answer")
  end

  it 'should not confirm security answer if not given' do
    subject.security_answer = nil
    subject.security_answer_confirmation = 'there hello'
    subject.valid?
    expect(subject.errors[:security_answer_confirmation]).to be_blank
  end

  it 'should require security answer on create' do
    expect(subject).to be_new_record
    subject.security_answer = nil
    subject.valid?
    expect(subject.errors[:security_answer]).to include("can't be blank")
  end

  it 'should require security answer confirmation if security answer given ' do
    subject.security_answer = 'hello there'
    subject.valid?
    expect(subject.errors[:security_answer_confirmation]).to include("can't be blank")
  end

  it 'should not require security answer confirmation if security answer is not given' do
    subject.security_answer = ''
    subject.valid?
    expect(subject.errors[:security_answer_confirmation]).to be_blank
  end

  it 'should require security answer digest on create' do
    subject = FactoryBot.build :test_model_with_attribute
    expect(subject).to be_new_record

    # change the security_answer_digest to verify the test
    subject.security_answer_digest = ''
    expect do
      begin
        subject.save!
      rescue Exception => ex
        expect(ex.message).to include("security_answer_digest missing on new record")
        raise
      end
    end.to raise_error RuntimeError
  end

  it 'should not require security answer digest on update' do
    subject = FactoryBot.build :test_model_with_attribute
    expect(subject).to be_new_record

    subject.save!

    # change the security_answer_digest to verify the test
    subject.security_answer_digest = ''

    subject.save!

    subject.reload
    expect(subject.security_answer_digest).to be_blank
  end

  it 'should allow to call security answer digest directly if protect setter for digest is not given as option' do
    expect do
      subject.security_answer_digest = 'hello'
    end.not_to raise_error
  end

  describe "#security_answer=" do
    it 'should set the security answer and save it encrypted' do
      tmwa = FactoryBot.create :test_model_with_attribute, security_answer: 'old answer', security_answer_confirmation: 'old answer'
      expect(tmwa.security_answer_digest).not_to be_blank
      old_security_answer_digest = tmwa.security_answer_digest

      tmwa.security_answer = 'new answer'
      tmwa.security_answer_confirmation = 'new answer'
      expect(tmwa.instance_variable_get(:@security_answer)).to eq('new answer')
      tmwa.save!
      expect(tmwa.security_answer_digest).not_to be_blank
      expect(tmwa.security_answer_digest).not_to eq(old_security_answer_digest)
    end
  end

  describe '#authenticate_security_answer' do
    it 'should return subject if security answer given matches the one stored' do
      tmwa = FactoryBot.create :test_model_with_attribute, security_answer: 'some answer', security_answer_confirmation: 'some answer'
      expect(tmwa.authenticate_security_answer('some answer')).to eq(tmwa)
    end

    it 'should return false if security answer given does not match the one stored' do
      tmwa = FactoryBot.create :test_model_with_attribute, security_answer: 'some answer', security_answer_confirmation: 'some answer'
      expect(tmwa.authenticate_security_answer('some other answer')).to eq(false)
    end
  end
end

describe TestModelWithAttributeNoValidation do
  it { expect(subject).to respond_to(:security_answer)               }
  it { expect(subject).to respond_to(:security_answer=)              }
  it { expect(subject).to_not respond_to(:security_answer_confirmation)  }
  it { expect(subject).to_not respond_to(:security_answer_confirmation=) }
  it { expect(subject).to respond_to(:authenticate_security_answer)  }

  it 'should not require security answer on create' do
    expect(subject).to be_new_record
    subject.security_answer = nil
    subject.valid?
    expect(subject.errors[:security_answer]).to be_blank
  end

  it 'should not require security answer confirmation if security answer given ' do
    subject.security_answer = 'hello there'
    subject.valid?
    expect(subject.errors[:security_answer_confirmation]).to be_blank
  end

  it 'should not require security answer confirmation if security answer is not given' do
    subject.security_answer = ''
    subject.valid?
    expect(subject.errors[:security_answer_confirmation]).to be_blank
  end

  it 'should not require security answer digest on create' do
    subject = FactoryBot.build :test_model_with_attribute_no_validation
    expect(subject).to be_new_record

    # change the security_answer_digest to verify the test
    subject.security_answer_digest = ''
    subject.save!
  end

  it 'should not require security answer digest on update' do
    subject = FactoryBot.build :test_model_with_attribute_no_validation
    expect(subject).to be_new_record

    subject.save!

    # change the security_answer_digest to verify the test
    subject.send :security_answer_digest=, ''

    subject.save!

    subject.reload
    expect(subject.security_answer_digest).to be_blank
  end
end

describe TestModelWithAttributeProtectSetterForDigest do
  it 'should not allow to call security answer digest directly' do
    expect do
      subject.security_answer_digest = 'hello'
    end.to raise_error NoMethodError
  end
end

describe TestModelWithAttributeWithCaseSensitive do
  it 'should authenticate even if answer is of different case' do
    t = FactoryBot.create :test_model_with_attribute_with_case_sensitive, security_answer: 'Answer', security_answer_confirmation: 'Answer'

    expect(t.authenticate_security_answer('answer')).to eq t
  end
end

describe TestModelWithAttributeDisableConfirmation do
  it { expect(subject).to_not respond_to(:security_answer_confirmation)  }
  it { expect(subject).to_not respond_to(:security_answer_confirmation=) }
  it 'should allow to create and save without any confirmation on security answer' do
    t = FactoryBot.create :test_model_with_attribute_disable_confirmation, security_answer: 'Answer'
    t.save!
    expect(t.authenticate_security_answer('another answer')).to eq(false)
    expect(t.authenticate_security_answer('Answer')).to eq(t)
  end
end

describe TestModelWithAlternativeSyntax do
  it { expect(subject).to respond_to(:username)               }
  it { expect(subject).to respond_to(:username=)              }
  it { expect(subject).to respond_to(:username_confirmation)  }
  it { expect(subject).to respond_to(:username_confirmation=) }
  it { expect(subject).to respond_to(:authenticate_username)  }

  context "with no validation" do
    it { expect(subject).to respond_to(:security_answer)               }
    it { expect(subject).to respond_to(:security_answer=)              }
    it { expect(subject).to_not respond_to(:security_answer_confirmation)  }
    it { expect(subject).to_not respond_to(:security_answer_confirmation=) }
    it { expect(subject).to respond_to(:authenticate_security_answer)  }
  end
end
