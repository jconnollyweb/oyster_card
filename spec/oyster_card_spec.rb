require 'oyster_card'

describe Oystercard do
    it 'has a balance of zero' do
        expect(subject.balance).to eq(0)
    end 

    describe "top_up" do
        it { is_expected.to respond_to(:top_up).with(1).argument }

        it 'can top up the balance' do
            expect { subject.top_up(1) }.to change{ subject.balance }.by(1)
        end

        it 'raises an error if limit is exceeded' do
            maximum_balance = Oystercard::MAXIMUM_BALANCE
            subject.top_up(maximum_balance)
            expect{ subject.top_up(1) }.to raise_error "Maximum balance of £90 exceeded"
        end
    end

    describe "deduct" do
        it 'deducts amount from balance' do
            subject.top_up(10)
            expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
        end
    end

    it 'is initially not in_journey' do
        expect(subject).not_to be_in_journey
    end

    it 'can touch_in' do
        subject.top_up(1)
        subject.touch_in
        expect(subject).to be_in_journey
    end

    it 'raises error if insufficient funds' do
        expect { subject.touch_in }.to raise_error "You have insufficient funds"
    end

    describe "touch_out "
        # before do
        # subject.instance_variable_set  (@balance: 5)
        # end 
        it 'can touch_out' do
            subject.top_up(5)
            subject.touch_in
            subject.touch_out
            expect(subject).not_to be_in_journey
        
        end
        it 'can charge you for the journey' do
            subject.top_up(5)
            subject.touch_in
            subject.touch_out
            expect{subject.touch_out}.to change {subject.balance}.by(-Oystercard::MINIMUM_CHARGE) 

        end
    end

end 