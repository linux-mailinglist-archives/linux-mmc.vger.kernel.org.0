Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4369CC635
	for <lists+linux-mmc@lfdr.de>; Sat,  5 Oct 2019 01:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJDXKT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 19:10:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:30093 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXKT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2019 19:10:19 -0400
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 19:10:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570230612;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Fpl157rZw7kboPBeaAFMZVFU1EaZImVHHtobJyIDJ08=;
        b=LcPIKRHQzXDfMrJ2Cfwkc6H1xRB+JOM3VqHcJ5w1xWLZ09b/9o6BACFDVorZExiq9m
        Eh718FflFluxvOMfS30CorQfqaVG1Fn+T0OzYAAYYAxsH8rx/iYZWKAQeOtr+wmwRrtP
        D38Er3+MO/3F86croxZcQO5ax5BbekewHjw/AnnYdXBHCojS4/PkE5Y0nv5Nl26bS0GY
        gSztx7g+j2Nm+9WwQah+7sSBC6QwTccGCUML8tULPGS7s915vxVwzdBMlszY3fMtbyWV
        uJ9wHs67Vvh7fHPd4bvk8nnNELbTsaNnFeulk0RIZMxEQaTYn16utpgYaF2LZy0whN2R
        3GPw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhWLruUDw4lbugEXqTsP2OdwP6HOA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:5860:ec51:d806:5a6c]
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id g03e8av94NA83X8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 5 Oct 2019 01:10:08 +0200 (CEST)
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <20191004225322.GA25745@shell.armlinux.org.uk>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <3c3dd3fa-92ed-a561-8cef-58ca64b4197a@xenosoft.de>
Date:   Sat, 5 Oct 2019 01:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004225322.GA25745@shell.armlinux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------2364C5B9BD46DFC509F78FC3"
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------2364C5B9BD46DFC509F78FC3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05 October 2019 at 00:53 am, Russell King - ARM Linux admin wrote:
> On Sat, Oct 05, 2019 at 12:45:29AM +0200, Christian Zigotzky wrote:
>> Hello,
>>
>> The onboard SD card of the Cyrus+ PowerPC board (A-EON AmigaOne X5000) [1]
>> doesn't work anymore after the 'mmc-v5.4-2' updates [2].
> Hi Christian,
>
> Please can you help us understand what is going on with your setup.
> Obviously, your board wants the SDHCI controller to be DMA coherent,
> but I guess that DT on your platform does not specify the
> "dma-coherent" property.  Can you confirm that?
>
> If that's the case, the question is what we do about that - do we add
> it (and wait for further reports?)
>
> The only alternative I can see is that we split ARM usage from PowerPC
> usage of this driver; it seems PowerPC can get away with being more
> lenient wrt DT DMA coherency correctness than the ARM architecture.
>
> Thanks.
>
Hi Russell,

I didn't find the property "dma-coherent" in the dtb source files 
(attached).

Output of "fdtdump cyrus_p5020_eth_poweroff.dtb | grep dma":

dma0 = "/soc@ffe000000/dma@100300";
         dma1 = "/soc@ffe000000/dma@101300";
         dma@100300 {
             compatible = "fsl,eloplus-dma";
             dma-channel@0 {
                 compatible = "fsl,eloplus-dma-channel";
             dma-channel@80 {
                 compatible = "fsl,eloplus-dma-channel";
             dma-channel@100 {
                 compatible = "fsl,eloplus-dma-channel";
             dma-channel@180 {
                 compatible = "fsl,eloplus-dma-channel";
         dma@101300 {
             compatible = "fsl,eloplus-dma";
             dma-channel@0 {
                 compatible = "fsl,eloplus-dma-channel";
             dma-channel@80 {
                 compatible = "fsl,eloplus-dma-channel";
             dma-channel@100 {
                 compatible = "fsl,eloplus-dma-channel";
             dma-channel@180 {
                 compatible = "fsl,eloplus-dma-channel";


Thanks,
Christian

--------------2364C5B9BD46DFC509F78FC3
Content-Type: text/plain; charset=UTF-8;
 name="cyrus-pre.dtsi"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cyrus-pre.dtsi"

LyoKICogUDUwMjAvUDUwMTAgU2lsaWNvbi9Tb0MgRGV2aWNlIFRyZWUgU291cmNlIChwcmUg
aW5jbHVkZSkKICoKICogQ29weXJpZ2h0IDIwMTEgLSAyMDE1IEZyZWVzY2FsZSBTZW1pY29u
ZHVjdG9yIEluYy4KICoKICogUmVkaXN0cmlidXRpb24gYW5kIHVzZSBpbiBzb3VyY2UgYW5k
IGJpbmFyeSBmb3Jtcywgd2l0aCBvciB3aXRob3V0CiAqIG1vZGlmaWNhdGlvbiwgYXJlIHBl
cm1pdHRlZCBwcm92aWRlZCB0aGF0IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9ucyBhcmUgbWV0
OgogKiAgICAgKiBSZWRpc3RyaWJ1dGlvbnMgb2Ygc291cmNlIGNvZGUgbXVzdCByZXRhaW4g
dGhlIGFib3ZlIGNvcHlyaWdodAogKiAgICAgICBub3RpY2UsIHRoaXMgbGlzdCBvZiBjb25k
aXRpb25zIGFuZCB0aGUgZm9sbG93aW5nIGRpc2NsYWltZXIuCiAqICAgICAqIFJlZGlzdHJp
YnV0aW9ucyBpbiBiaW5hcnkgZm9ybSBtdXN0IHJlcHJvZHVjZSB0aGUgYWJvdmUgY29weXJp
Z2h0CiAqICAgICAgIG5vdGljZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBm
b2xsb3dpbmcgZGlzY2xhaW1lciBpbiB0aGUKICogICAgICAgZG9jdW1lbnRhdGlvbiBhbmQv
b3Igb3RoZXIgbWF0ZXJpYWxzIHByb3ZpZGVkIHdpdGggdGhlIGRpc3RyaWJ1dGlvbi4KICog
ICAgICogTmVpdGhlciB0aGUgbmFtZSBvZiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBub3Ig
dGhlCiAqICAgICAgIG5hbWVzIG9mIGl0cyBjb250cmlidXRvcnMgbWF5IGJlIHVzZWQgdG8g
ZW5kb3JzZSBvciBwcm9tb3RlIHByb2R1Y3RzCiAqICAgICAgIGRlcml2ZWQgZnJvbSB0aGlz
IHNvZnR3YXJlIHdpdGhvdXQgc3BlY2lmaWMgcHJpb3Igd3JpdHRlbiBwZXJtaXNzaW9uLgog
KgogKgogKiBBTFRFUk5BVElWRUxZLCB0aGlzIHNvZnR3YXJlIG1heSBiZSBkaXN0cmlidXRl
ZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlCiAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
ICgiR1BMIikgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlCiAqIEZvdW5kYXRp
b24sIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhhdCBMaWNlbnNlIG9yIChhdCB5b3VyIG9wdGlv
bikgYW55CiAqIGxhdGVyIHZlcnNpb24uCiAqCiAqIFRISVMgU09GVFdBUkUgSVMgUFJPVklE
RUQgQlkgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IgYGBBUyBJUycnIEFORCBBTlkKICogRVhQ
UkVTUyBPUiBJTVBMSUVEIFdBUlJBTlRJRVMsIElOQ0xVRElORywgQlVUIE5PVCBMSU1JVEVE
IFRPLCBUSEUgSU1QTElFRAogKiBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSBBTkQg
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQVJFCiAqIERJU0NMQUlNRUQuIElO
IE5PIEVWRU5UIFNIQUxMIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yIEJFIExJQUJMRSBGT1Ig
QU5ZCiAqIERJUkVDVCwgSU5ESVJFQ1QsIElOQ0lERU5UQUwsIFNQRUNJQUwsIEVYRU1QTEFS
WSwgT1IgQ09OU0VRVUVOVElBTCBEQU1BR0VTCiAqIChJTkNMVURJTkcsIEJVVCBOT1QgTElN
SVRFRCBUTywgUFJPQ1VSRU1FTlQgT0YgU1VCU1RJVFVURSBHT09EUyBPUiBTRVJWSUNFUzsK
ICogTE9TUyBPRiBVU0UsIERBVEEsIE9SIFBST0ZJVFM7IE9SIEJVU0lORVNTIElOVEVSUlVQ
VElPTikgSE9XRVZFUiBDQVVTRUQgQU5ECiAqIE9OIEFOWSBUSEVPUlkgT0YgTElBQklMSVRZ
LCBXSEVUSEVSIElOIENPTlRSQUNULCBTVFJJQ1QgTElBQklMSVRZLCBPUiBUT1JUCiAqIChJ
TkNMVURJTkcgTkVHTElHRU5DRSBPUiBPVEhFUldJU0UpIEFSSVNJTkcgSU4gQU5ZIFdBWSBP
VVQgT0YgVEhFIFVTRSBPRiBUSElTCiAqIFNPRlRXQVJFLCBFVkVOIElGIEFEVklTRUQgT0Yg
VEhFIFBPU1NJQklMSVRZIE9GIFNVQ0ggREFNQUdFLgogKi8KCi9kdHMtdjEvOwoKL2luY2x1
ZGUvICJlNTUwMF9wb3dlcl9pc2EuZHRzaSIKCi8gewoJY29tcGF0aWJsZSA9ICJmc2wsUDUw
MjAiOwoJI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cgkjc2l6ZS1jZWxscyA9IDwyPjsKCWludGVy
cnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoKCWFsaWFzZXMgewoJCWNjc3IgPSAmc29jOwoJCWRj
c3IgPSAmZGNzcjsKCgkJc2VyaWFsMCA9ICZzZXJpYWwwOwoJCXNlcmlhbDEgPSAmc2VyaWFs
MTsKCQlzZXJpYWwyID0gJnNlcmlhbDI7CgkJc2VyaWFsMyA9ICZzZXJpYWwzOwoJCXBjaTAg
PSAmcGNpMDsKCQlwY2kxID0gJnBjaTE7CgkJcGNpMiA9ICZwY2kyOwoJCXBjaTMgPSAmcGNp
MzsKCQl1c2IwID0gJnVzYjA7CgkJdXNiMSA9ICZ1c2IxOwoJCWRtYTAgPSAmZG1hMDsKCQlk
bWExID0gJmRtYTE7CgkJc2RoYyA9ICZzZGhjOwoJCW1zaTAgPSAmbXNpMDsKCQltc2kxID0g
Jm1zaTE7CgkJbXNpMiA9ICZtc2kyOwoKCQljcnlwdG8gPSAmY3J5cHRvOwoJCXNlY19qcjAg
PSAmc2VjX2pyMDsKCQlzZWNfanIxID0gJnNlY19qcjE7CgkJc2VjX2pyMiA9ICZzZWNfanIy
OwoJCXNlY19qcjMgPSAmc2VjX2pyMzsKCQlydGljX2EgPSAmcnRpY19hOwoJCXJ0aWNfYiA9
ICZydGljX2I7CgkJcnRpY19jID0gJnJ0aWNfYzsKCQlydGljX2QgPSAmcnRpY19kOwoJCXNl
Y19tb24gPSAmc2VjX21vbjsKCgkJcmFpZGVuZyA9ICZyYWlkZW5nOwoJCXJhaWRlbmdfanIw
ID0gJnJhaWRlbmdfanIwOwoJCXJhaWRlbmdfanIxID0gJnJhaWRlbmdfanIxOwoJCXJhaWRl
bmdfanIyID0gJnJhaWRlbmdfanIyOwoJCXJhaWRlbmdfanIzID0gJnJhaWRlbmdfanIzOwoK
CQlmbWFuMCA9ICZmbWFuMDsKCQlldGhlcm5ldDAgPSAmZW5ldDM7CgkJZXRoZXJuZXQxID0g
JmVuZXQ0OwoJfTsKCgljcHVzIHsKCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkjc2l6ZS1j
ZWxscyA9IDwwPjsKCgkJY3B1MDogUG93ZXJQQyxlNTUwMEAwIHsKCQkJZGV2aWNlX3R5cGUg
PSAiY3B1IjsKCQkJcmVnID0gPDA+OwoJCQljbG9ja3MgPSA8Jm11eDA+OwoJCQluZXh0LWxl
dmVsLWNhY2hlID0gPCZMMl8wPjsKCQkJZnNsLHBvcnRpZC1tYXBwaW5nID0gPDB4ODAwMDAw
MDA+OwoJCQlMMl8wOiBsMi1jYWNoZSB7CgkJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjcGM+
OwoJCQl9OwoJCX07CgkJY3B1MTogUG93ZXJQQyxlNTUwMEAxIHsKCQkJZGV2aWNlX3R5cGUg
PSAiY3B1IjsKCQkJcmVnID0gPDE+OwoJCQljbG9ja3MgPSA8Jm11eDE+OwoJCQluZXh0LWxl
dmVsLWNhY2hlID0gPCZMMl8xPjsKCQkJZnNsLHBvcnRpZC1tYXBwaW5nID0gPDB4NDAwMDAw
MDA+OwoJCQlMMl8xOiBsMi1jYWNoZSB7CgkJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjcGM+
OwoJCQl9OwoJCX07Cgl9Owp9Owo=
--------------2364C5B9BD46DFC509F78FC3
Content-Type: audio/vnd.dts;
 name="cyrus_p5020.eth.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cyrus_p5020.eth.dts"

LyoKICogQ3lydXMgNTAyMCBEZXZpY2UgVHJlZSBTb3VyY2UsIGJhc2VkIG9uIHA1MDIwZHMu
ZHRzCiAqCiAqIENvcHlyaWdodCAyMDE1IEFuZHkgRmxlbWluZwogKgogKiBwNTAyMGRzLmR0
cyBjb3B5cmlnaHQ6CiAqIENvcHlyaWdodCAyMDEwIC0gMjAxNCBGcmVlc2NhbGUgU2VtaWNv
bmR1Y3RvciBJbmMuCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSAgaXQgYW5kL29yIG1vZGlmeSBpdAogKiB1bmRlciAgdGhlIHRl
cm1zIG9mICB0aGUgR05VIEdlbmVyYWwgIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eSB0aGUKICogRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyAgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgIExpY2Vuc2UsIG9yIChhdCB5b3VyCiAqIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCiAqLwoKL2luY2x1ZGUvICJjeXJ1cy1wcmUuZHRzaSIKCi8gewoJbW9kZWwgPSAidmFy
aXN5cyxDWVJVUyI7Cgljb21wYXRpYmxlID0gInZhcmlzeXMsQ1lSVVMiOwoJI2FkZHJlc3Mt
Y2VsbHMgPSA8Mj47Cgkjc2l6ZS1jZWxscyA9IDwyPjsKCWludGVycnVwdC1wYXJlbnQgPSA8
Jm1waWM+OwoKCWFsaWFzZXMgewoJCXBoeV9yZ21paV8zID0gJnBoeV9yZ21paV8zOwoJCXBo
eV9yZ21paV83ID0gJnBoeV9yZ21paV83OwoJfTsKCgltZW1vcnkgewoJCWRldmljZV90eXBl
ID0gIm1lbW9yeSI7Cgl9OwoKCXJlc2VydmVkLW1lbW9yeSB7CgkJI2FkZHJlc3MtY2VsbHMg
PSA8Mj47CgkJI3NpemUtY2VsbHMgPSA8Mj47CgkJcmFuZ2VzOwoKCQlibWFuX2ZicHI6IGJt
YW4tZmJwciB7CgkJCXNpemUgPSA8MCAweDEwMDAwMDA+OwoJCQlhbGlnbm1lbnQgPSA8MCAw
eDEwMDAwMDA+OwoJCX07CgkJcW1hbl9mcWQ6IHFtYW4tZnFkIHsKCQkJc2l6ZSA9IDwwIDB4
NDAwMDAwPjsKCQkJYWxpZ25tZW50ID0gPDAgMHg0MDAwMDA+OwoJCX07CgkJcW1hbl9wZmRy
OiBxbWFuLXBmZHIgewoJCQlzaXplID0gPDAgMHgyMDAwMDAwPjsKCQkJYWxpZ25tZW50ID0g
PDAgMHgyMDAwMDAwPjsKCQl9OwoJfTsKCglkY3NyOiBkY3NyQGYwMDAwMDAwMCB7CgkJcmFu
Z2VzID0gPDB4MDAwMDAwMDAgMHhmIDB4MDAwMDAwMDAgMHgwMTAwODAwMD47Cgl9OwoKCWJw
b3J0YWxzOiBibWFuLXBvcnRhbHNAZmY0MDAwMDAwIHsKCQlyYW5nZXMgPSA8MHgwIDB4ZiAw
eGY0MDAwMDAwIDB4MjAwMDAwPjsKCX07CgoJcXBvcnRhbHM6IHFtYW4tcG9ydGFsc0BmZjQy
MDAwMDAgewoJCXJhbmdlcyA9IDwweDAgMHhmIDB4ZjQyMDAwMDAgMHgyMDAwMDA+OwoJfTsK
Cglzb2M6IHNvY0BmZmUwMDAwMDAgewoJCXJhbmdlcyA9IDwweDAwMDAwMDAwIDB4ZiAweGZl
MDAwMDAwIDB4MTAwMDAwMD47CgkJcmVnID0gPDB4ZiAweGZlMDAwMDAwIDAgMHgwMDAwMTAw
MD47CgkJc3BpQDExMDAwMCB7CgkJfTsKCgkJaTJjQDExODEwMCB7CgkJfTsKCgkJaTJjQDEx
OTEwMCB7CgkJCXJ0Y0A2ZiB7CgkJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtY3A3OTQx
eCI7CgkJCQlyZWcgPSA8MHg2Zj47CgkJCX07CgkJfTsKCQlmbWFuQDQwMDAwMCB7CgoJCQlt
ZGlvQGUxMTIwIHsKCgkJCQlwaHlfcmdtaWlfMzogZXRoZXJuZXQtcGh5QDMgewoJCQkJCXJl
ZyA9IDwweDM+OwoJCQkJfTsKCgkJCQlwaHlfcmdtaWlfNzogZXRoZXJuZXQtcGh5QDcgewoJ
CQkJCXJlZyA9IDwweDc+OwoJCQkJfTsKCQkJfTsKCgkJCWV0aGVybmV0QGU2MDAwIHsKCQkJ
CXBoeS1oYW5kbGUgPSA8JnBoeV9yZ21paV8zPjsKCQkJCXBoeS1jb25uZWN0aW9uLXR5cGUg
PSAicmdtaWkiOwoJCQl9OwoKCQkJZXRoZXJuZXRAZTgwMDAgewoJCQkJcGh5LWhhbmRsZSA9
IDwmcGh5X3JnbWlpXzc+OwoJCQkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJyZ21paSI7CgkJ
CX07CgoJCX07Cgl9OwoKCXJpbzogcmFwaWRpb0BmZmUwYzAwMDAgewoJCXJlZyA9IDwweGYg
MHhmZTBjMDAwMCAwIDB4MTEwMDA+OwoKCQlwb3J0MSB7CgkJCXJhbmdlcyA9IDwwIDAgMHhj
IDB4MjAwMDAwMDAgMCAweDEwMDAwMDAwPjsKCQl9OwoJCXBvcnQyIHsKCQkJcmFuZ2VzID0g
PDAgMCAweGMgMHgzMDAwMDAwMCAwIDB4MTAwMDAwMDA+OwoJCX07Cgl9OwoKCWxiYzogbG9j
YWxidXNAZmZlMTI0MDAwIHsKCQlyZWcgPSA8MHhmIDB4ZmUxMjQwMDAgMCAweDEwMDA+OwoJ
CXJhbmdlcyA9IDwwIDAgMHhmIDB4ZTgwMDAwMDAgMHgwODAwMDAwMAoJCQkgIDIgMCAweGYg
MHhmZmEwMDAwMCAweDAwMDQwMDAwCgkJCSAgMyAwIDB4ZiAweGZmZGYwMDAwIDB4MDAwMDgw
MDA+OwoJfTsKCglwY2kwOiBwY2llQGZmZTIwMDAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMjAw
MDAwIDAgMHgxMDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAwIDB4ZTAwMDAwMDAgMHhj
IDB4MDAwMDAwMDAgMHgwIDB4MjAwMDAwMDAKCQkJICAweDAxMDAwMDAwIDAgMHgwMDAwMDAw
MCAweGYgMHhmODAwMDAwMCAweDAgMHgwMDAxMDAwMD47CgkJcGNpZUAwIHsKCQkJcmFuZ2Vz
ID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIwMDAwMDAgMCAweGUwMDAw
MDAwCgkJCQkgIDAgMHgyMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAK
CQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAweDAwMDEwMDAwPjsKCQl9
OwoJfTsKCglwY2kxOiBwY2llQGZmZTIwMTAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMjAxMDAw
IDAgMHgxMDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAweDAgMHhlMDAwMDAwMCAweGMg
MHgyMDAwMDAwMCAweDAgMHgyMDAwMDAwMAoJCQkgIDB4MDEwMDAwMDAgMHgwIDB4MDAwMDAw
MDAgMHhmIDB4ZjgwMTAwMDAgMHgwIDB4MDAwMTAwMDA+OwoJCXBjaWVAMCB7CgkJCXJhbmdl
cyA9IDwweDAyMDAwMDAwIDAgMHhlMDAwMDAwMAoJCQkJICAweDAyMDAwMDAwIDAgMHhlMDAw
MDAwMAoJCQkJICAwIDB4MjAwMDAwMDAKCgkJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAw
CgkJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAwCgkJCQkgIDAgMHgwMDAxMDAwMD47CgkJ
fTsKCX07CgoJcGNpMjogcGNpZUBmZmUyMDIwMDAgewoJCXJlZyA9IDwweGYgMHhmZTIwMjAw
MCAwIDB4MTAwMD47CgkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwIDB4YyAw
eDQwMDAwMDAwIDAgMHgyMDAwMDAwMAoJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAwIDB4
ZiAweGY4MDIwMDAwIDAgMHgwMDAxMDAwMD47CgkJcGNpZUAwIHsKCQkJcmFuZ2VzID0gPDB4
MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJ
CQkgIDAgMHgyMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAg
MHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAweDAwMDEwMDAwPjsKCQl9OwoJfTsK
CglwY2kzOiBwY2llQGZmZTIwMzAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMjAzMDAwIDAgMHgx
MDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAwIDB4ZTAwMDAwMDAgMHhjIDB4NjAwMDAw
MDAgMCAweDIwMDAwMDAwCgkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAgMHhmIDB4Zjgw
MzAwMDAgMCAweDAwMDEwMDAwPjsKCQlwY2llQDAgewoJCQlyYW5nZXMgPSA8MHgwMjAwMDAw
MCAwIDB4ZTAwMDAwMDAKCQkJCSAgMHgwMjAwMDAwMCAwIDB4ZTAwMDAwMDAKCQkJCSAgMCAw
eDIwMDAwMDAwCgoJCQkJICAweDAxMDAwMDAwIDAgMHgwMDAwMDAwMAoJCQkJICAweDAxMDAw
MDAwIDAgMHgwMDAwMDAwMAoJCQkJICAwIDB4MDAwMTAwMDA+OwoJCX07Cgl9Owp9OwoKL2lu
Y2x1ZGUvICJwNTAyMHNpLXBvc3QuZHRzaSIK
--------------2364C5B9BD46DFC509F78FC3--
