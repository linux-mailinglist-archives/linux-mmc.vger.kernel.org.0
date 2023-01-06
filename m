Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6624C65FCF3
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Jan 2023 09:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjAFIl7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Jan 2023 03:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAFIl6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2023 03:41:58 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467014166A;
        Fri,  6 Jan 2023 00:41:56 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E181124E1BB;
        Fri,  6 Jan 2023 16:41:48 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 6 Jan
 2023 16:41:48 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 6 Jan
 2023 16:41:48 +0800
Message-ID: <e1e75e70-2143-defb-b6ff-1ec41df19bba@starfivetech.com>
Date:   Fri, 6 Jan 2023 16:41:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-kernel@vger.kernel.org>
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-4-william.qiu@starfivetech.com>
 <CAPDyKFqziA+PB__v8nJzgkTuM9ZszW8X2U-akvRFv0_qwZ22OA@mail.gmail.com>
 <14433b44-8359-b9e8-446c-bb49e86bf48f@starfivetech.com>
 <CAPDyKFrH=U-Sz1Kx2AJ+X_FXi9GcEdHXjO+aC=MXpGP_+xgOsQ@mail.gmail.com>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAPDyKFrH=U-Sz1Kx2AJ+X_FXi9GcEdHXjO+aC=MXpGP_+xgOsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2023/1/5 0:05, Ulf Hansson wrote:
> On Wed, 4 Jan 2023 at 07:08, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>>
>>
>> On 2023/1/2 22:03, Ulf Hansson wrote:
>> > On Tue, 27 Dec 2022 at 13:22, William Qiu <william.qiu@starfivetech.com> wrote:
>> >>
>> >> This adds the mmc node for the StarFive JH7110 SoC.
>> >> Set sdioo node to emmc and set sdio1 node to sd.
>> >>
>> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> >> ---
>> >>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
>> >>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
>> >>  2 files changed, 63 insertions(+)
>> >>
>> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> >> index c8946cf3a268..d8244fd1f5a0 100644
>> >> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> >> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> >> @@ -47,6 +47,31 @@ &clk_rtc {
>> >>         clock-frequency = <32768>;
>> >>  };
>> >>
>> >> +&mmc0 {
>> >> +       max-frequency = <100000000>;
>> >> +       card-detect-delay = <300>;
>> >
>> > Nitpick:  This seems redundant for a non-removable card!?
>> >
>>
>> Will drop
>>
>> >> +       bus-width = <8>;
>> >> +       cap-mmc-highspeed;
>> >> +       mmc-ddr-1_8v;
>> >> +       mmc-hs200-1_8v;
>> >> +       non-removable;
>> >> +       cap-mmc-hw-reset;
>> >> +       post-power-on-delay-ms = <200>;
>> >> +       status = "okay";
>> >> +};
>> >> +
>> >> +&mmc1 {
>> >> +       max-frequency = <100000000>;
>> >> +       card-detect-delay = <300>;
>> >
>> > Nitpick: This looks redundant for polling based card detection
>> > (broken-cd is set a few lines below).
>> >
>>
>> Will drop
>>
>> >> +       bus-width = <4>;
>> >> +       no-sdio;
>> >> +       no-mmc;
>> >> +       broken-cd;
>> >> +       cap-sd-highspeed;
>> >> +       post-power-on-delay-ms = <200>;
>> >> +       status = "okay";
>> >> +};
>> >> +
>> >>  &gmac0_rmii_refin {
>> >>         clock-frequency = <50000000>;
>> >>  };
>> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> >> index c22e8f1d2640..08a780d2c0f4 100644
>> >> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> >> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> >> @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
>> >>                         #reset-cells = <1>;
>> >>                 };
>> >>
>> >> +               syscon: syscon@13030000 {
>> >> +                       compatible = "starfive,syscon", "syscon";
>> >> +                       reg = <0x0 0x13030000 0x0 0x1000>;
>> >> +               };
>> >> +
>> >>                 gpio: gpio@13040000 {
>> >>                         compatible = "starfive,jh7110-sys-pinctrl";
>> >>                         reg = <0x0 0x13040000 0x0 0x10000>;
>> >> @@ -433,5 +438,38 @@ uart5: serial@12020000 {
>> >>                         reg-shift = <2>;
>> >>                         status = "disabled";
>> >>                 };
>> >> +
>> >> +               /* unremovable emmc as mmcblk0 */
>> >
>> > Don't confuse the mmc0 node name with mmcblk0. There is no guarantee
>> > that this is true, unless you also specify an alias.
>> >
>>
>> Hi Ulf,
>>
>> Thank you for taking time to review and provide helpful comments for this patch.
>> Actually we define mmc0 as eMMC, which is mmcblk0 in the kernel, and define mmc1 as SDIO,
>> which is mmcblk1 in the kernel, so it's not confuse.
>>
> 
> My point is, mmc0 from DT node perspective doesn't necessarily need to
> map to mmc0, as that depends on the "probe" order of the devices. At
> least for the Linux kernel, mmc0 from DT point of view, could end up
> being mmc1.
> 
> To avoid confusion, please drop the "mmcblk*" here. It's anyway a
> Linux specific thing. Don't get me wrong, feel free to keep the
> information about eMMC and SDIO for the corresponding mmc controller
> node.
> 
> Moreover, if you can't use PARTID/UUID to find the rootfs device -
> then you may use an aliases node, to let mmc0 to be enumerated as
> mmc0, for example. See below.
> 
> aliases {
>      mmc0 = &mmc0;
> }
> 
> Kind regards
> Uffe

Hi Uffe,

Thank you for taking time to review.
I'll take your suggestion into consideration and drop the "mmcblk*".

Best Regards
William Qiu
