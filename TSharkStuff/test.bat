
@ECHO OFF

tshark -a duration:10 -w test.pcap
tshark -r test.pcap -Y "btcommon.eir_ad.entry.company_id == 0x004c" -T fields -e btle.advertising_address -E header=y -E separator=, -E quote=d -E occurrence=f > test.csv