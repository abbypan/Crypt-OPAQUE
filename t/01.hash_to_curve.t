use strict;
use warnings;

use Test::More ;
use Crypt::OpenSSL::EC;
use Crypt::OpenSSL::Bignum;
use Crypt::OpenSSL::Hash2Curve ;
#use Data::Dump qw/dump/;

#blind: x, dst, P= hash_to_group(x, dst), blind, blinded_element
#b'CorrectHorseBatteryStaple'
#b'HashToGroup-VOPRF09-\x00\x00\x03'
#(108215862071700875298724019606939912444153626818413494250362195381812450231191 : 71000501178085768069715675843917698566665450797021384739574024561085338699369 : 1)
#0xef4001e3fba24cdb34a89f18d61f79400b9d8fbe475c14e909929052b8530397
#0x9cf8dc0cb7696c82bb4580295c97c01f28c6d30e9f667a5858b9660e11014669
#29449707829628350477538497042255723126523740212542915258485686493487085093203
#(72769161113821731742088354227677360049947088887384373015988766121383705259304 : 77844362313912955796799278097891121910670213460784779952645707324555334308840 : 1)
#0xa0e1e2b7d6676136224e19c9fdd495d91f49bfe5e8a192e712f065a448e52d28
#0xac1a5902e93b42100833f0de44730045474d9b527e605593b3be73248a90d3e8


my $msg='CorrectHorseBatteryStaple';
my $DST = 'HashToGroup-VOPRF09-'.pack("H*", '000003');
#my $DST = 'HashToGroup-VOPRF09-'.pack("H*", '000003').'P256_XMD:SHA-256_SSWU_RO_';

my $group_name = "prime256v1";
my $type = 'sswu';
#my $P = hash_to_curve($msg, $DST, $group_name, $type, 'SHA256', \&Crypt::OpenSSL::Hash2Curve::expand_message_xmd , 0 );
my $P = hash_to_curve($msg, $DST, $group_name, $type, 'SHA256', \&expand_message_xmd , 1 );

my $params_ref = get_hash2curve_params($group_name, $type);
my $group = $params_ref->[0];
my $ctx = $params_ref->[-1];
my $bn = Crypt::OpenSSL::EC::EC_POINT::point2hex($group, $P, 4, $ctx);
print $bn, "\n";
is($bn, '04EF4001E3FBA24CDB34A89F18D61F79400B9D8FBE475C14E909929052B85303979CF8DC0CB7696C82BB4580295C97C01F28C6D30E9F667A5858B9660E11014669', 'hash_to_curve');


done_testing;

