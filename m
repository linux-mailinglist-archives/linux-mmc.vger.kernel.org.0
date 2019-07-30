Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375E17A943
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Jul 2019 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfG3NRO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 30 Jul 2019 09:17:14 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:53536 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730513AbfG3NRN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2019 09:17:13 -0400
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 09:17:12 EDT
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6UCrT1q016824
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jul 2019 13:56:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=to : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp;
 bh=no/t2/x989dqDh7eVpkR1pAbO6gqVrgnD6Ho2bhSZ1M=;
 b=ZL+Av4CNMdiH/YHudogCICNRkgX2W2dDSoMlxuYQnoRABk/OVHWHNtDUgBrFR1e6ckt4
 4jFEGeAMVIAvxE11MhIsp+t4/Roqesa7H1XxVIxD4JOHLQmNgEbBZzPnRh7LVpoELSxX
 ZBM5m7tF93cs3M71+UveliSjZ6d3dwdxWaoNi370VqPgagTyRnVD/jOoJK0E2+GWnOM8
 JEmsRaNiaeRmKkhlG5CyCq+JOlFs/npquambcAqRwshy1CIPBohjo9rymRal6VNvYgnM
 ey3OgnZuHHiPg1c7K9hGiHHkq59mXQJ2mbanos2O2qfUzu4/s1U4cKF2l9FEFKIcJJv2 zQ== 
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        by mx08-00252a01.pphosted.com with ESMTP id 2u0b3g9tt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jul 2019 13:56:35 +0100
Received: by mail-wr1-f72.google.com with SMTP id w11so31759539wrl.7
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jul 2019 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=no/t2/x989dqDh7eVpkR1pAbO6gqVrgnD6Ho2bhSZ1M=;
        b=VENYHMlt+0ZxLutduQsUFsqfBxn/mAsHva/VP7blhpRRnPwGbNe2lPJL8+9ir3Mv8P
         79xCB4W+nr3j/uNiGQIZS4k9gIKlKjyYH68qPtNiZ6vaXFpk53Mgz4hS2oQ0Fa9jSRAk
         44IreYrIqCDqYzmEfVIcADZHLWmRWPMO5GFNi/wcn+xTmL4OUaLGyz+Ii+o6WgC8rFdD
         1FrzQDAXpHZzeHik8EMbyUF5SL7Tf/lHVV7kc16XQvgqrU22Mhuij+9Gkr2AX52EFFNi
         mRvN+k4+OHgMwQ0Wheig2XOp/bq+SVWzHMh16fR7FYA8HIlAoKetY4PC/mUlfSU4sa4w
         3yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=no/t2/x989dqDh7eVpkR1pAbO6gqVrgnD6Ho2bhSZ1M=;
        b=VOmiaF+S3umuTtOtbmSJBCwf//zgtDJyOTOzAL3hHAj3yTh/h4/Et97pO9JVouRc5b
         xpcgLhMfhPQCgkkqy3ycT69a+g86EkILBhi9n24rstk3VEnSBfsEpAQ7CeLkAFQaQyEx
         Vl3oqUm1KyK4mSEUhIjz6OfQ54RcIpZU5FAxA1fcMFNkgyKPL9hAmqcYl2nW0RRAdjc8
         femVTwxes1SzKjM50eDNcm4f62slM+rqv600/EocdQkZjAg8lcFHw57RWaLa+HRvto/8
         jYcisqDR1Ovypr90yC2Tb52FZtPKvuK3+UR0PFyAKmbWmZv0nJbZ9QZdoXmWGW1E9Xj3
         gzoQ==
X-Gm-Message-State: APjAAAXpdvHY2hVagI1owqQxhEJemUOnFyHrf/2SRzDf8NmsGixnqEIR
        ByQohSyLxb6sKWtGXiRgJXZ+vHHiOxJSasdBn+IeJOxvaVGCxhzwieEJvyi+b9TWwKFAypM2pzY
        j28PR0lsndnupnrOD4nf2
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr33446695wrt.106.1564491394783;
        Tue, 30 Jul 2019 05:56:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwq0KNOyRuNsGhIJWVxoxnbRTiD05+9u7uKjeugoN18xk7zXqGaB0xCaDlOL7t4Yni/VFzBcw==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr33446685wrt.106.1564491394539;
        Tue, 30 Jul 2019 05:56:34 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:40ff:d16c:6d72:46fd? ([2a00:1098:3142:14:40ff:d16c:6d72:46fd])
        by smtp.gmail.com with ESMTPSA id r5sm70067154wmh.35.2019.07.30.05.56.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:56:33 -0700 (PDT)
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Phil Elwell <phil@raspberrypi.org>
Subject: Possible bug in sdhci_set_power_reg
Message-ID: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
Date:   Tue, 30 Jul 2019 13:56:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-30_06:2019-07-29,2019-07-30 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi MMC team,

I've spent some time trying to add a regulator to control power to an SD card
(vmmc-supply) on an SDHCI-equipped system. After a few false starts and red herrings
I found that powering up the regulator during the boot process was effectively disabling
the SDHCI controller. Note that this was despite having regulator-boot-on set in the
device tree.

The problem seems to be in sdhci_set_power_reg:

	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);

	if (mode != MMC_POWER_OFF)
		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
	else
		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);

This looks plausible for the MMC_POWER_OFF case, but setting the SDHCI_POWER_CONTROL
register to SDHCI_POWER_ON (0x01) has the side effect of settings the SD Bus Voltage
Select bits to 0b000 (a reserved value).

sdhci_set_power_noreg() includes logic to calculate the correct values for the voltage
select bits, so I found that (in my limited test cases) replacing the if/else above
with a chain call to sdhci_set_power_noreg() was sufficient to get everything working.

Can anyone tell me what I've been doing wrong, or suggest a better "fix"?

Thanks for your time,

Phil Elwell
