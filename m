Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33465A7C10
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfIDGxk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 02:53:40 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:38612 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDGxk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 02:53:40 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 22A8D3E4D4;
        Wed,  4 Sep 2019 14:53:32 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3793T140254004627200S1567580009523516_;
        Wed, 04 Sep 2019 14:53:30 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5b2d73b1785b7caf807279e5fb39fd6a>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: dianders@chromium.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mmc=3a_dw=5fmmc-rockchip=3a_Using_180_s?=
 =?UTF-8?B?YW1wbGUgcGhhc2UgaWYgYWxsIHBoYXNlcyB3b3Jr44CQ6K+35rOo5oSP77yM6YKu?=
 =?UTF-8?Q?=e4=bb=b6=e7=94=b1linux-rockchip-bounces+shawn=2elin=3drock-chips?=
 =?UTF-8?B?LmNvbUBsaXN0cy5pbmZyYWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFpmh2zcz7=zL77XGBHUhxcFquoMSiRHf8w3dnvwH50aYw@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <39217c20-5792-73da-958a-088aea519149@rock-chips.com>
Date:   Wed, 4 Sep 2019 14:53:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpmh2zcz7=zL77XGBHUhxcFquoMSiRHf8w3dnvwH50aYw@mail.gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2019/9/4 14:32, Ulf Hansson wrote:
> On Wed, 4 Sep 2019 at 04:28, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> default_sample_phase is used to make sure the cards are enumurated
>> properly and will be set to 0 if not assigned. However, the sample
>> phase should depends on the tuned phase if running higher clock rate.
>> If all phases work but default_sample_phase isn't assigned, driver
>> set sample phase to 0 for this case, which isn't the best choice,
>> because we always expect to set phase to the middle of window. To
>> solve the following continually issues we have seen in the test, we
>> need set phase to the more stable one, 180, if all phases work.
>>
>> mmcblk1: error -84 transferring data, sector 1735064, nr 8, cmd
>> response 0x900, card status 0xb00
>> mmcblk1: retrying using single block read
>> dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
>> mmcblk1: retrying because a re-tune was needed
>>
>> .....
>>
>> mmcblk1: error -84 transferring data, sector 1728672, nr 248, cmd
>> response 0x900, card status 0xb00
>> mmcblk1: retrying using single block read
>> dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Is this ready to be tagged for stable, or think its better to get it
> tested a while and then send a backport to Greg etc instead?
> 

Thanks, Ulf. I would prefer to get it tested in -next and will send
backport patches to the revelent stable kernels.

> In any case, applied for next, thanks!
> 
> Kind regards
> Uffe
> 
> 
>> ---
>>
>>   drivers/mmc/host/dw_mmc-rockchip.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>> index d4d0213..9ef9723 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -209,9 +209,8 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>>          }
>>
>>          if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
>> -               clk_set_phase(priv->sample_clk, priv->default_sample_phase);
>> -               dev_info(host->dev, "All phases work, using default phase %d.",
>> -                        priv->default_sample_phase);
>> +               clk_set_phase(priv->sample_clk, 180);
>> +               dev_info(host->dev, "All phases work, using phase 180.");
>>                  goto free;
>>          }
>>
>> --
>> 1.9.1
>>
>>
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 


