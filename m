Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56073F967E
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 18:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLRCa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Nov 2019 12:02:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfKLRC3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2019 12:02:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so19348513wrm.8
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=nEAXtzDBm38sh308ifQWQizcwae+A2CoWPbIiFYwKrk=;
        b=LZPycnekykDy+3tCiWfVwLE36sDID8Ih91KLiTQsDq2UDK0g+60HWQTUSJeQOiTlgm
         HLun017COts3Oj49wRtR7jYQnffJpNSKdCgH1t6JSFMBRdVbPo+zdxDNsjx4izyrLTou
         vR2EMSCd60AIz+fhhXUONam91Y+brzLhlRNz+KOxzohyjjZ0MX22dKVS9bS3l7reBCNv
         zamdsjIOQrRThhJKGjahl1vt2XmE4bO+I/D2k8a2N6BosYO3/oEUoYD7EkAoo8h0Z62I
         7fGRjKVZg7rERLDNxNUrJoCXfC+jBchzsk8m6TdIrsiShDBTWVpg3+7oPlF+wydkukyX
         PRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=nEAXtzDBm38sh308ifQWQizcwae+A2CoWPbIiFYwKrk=;
        b=gWjNh/qGCKjBpOZ7tlbYFd9pe+M6T8LaRhdR9eVv8hyIhVWlHT3hUjng5mp7hw1qKf
         Y+snpMHMwkNKr5SICypAWAXECvkgZycG2eEhOOzdDGb0SsC908I8aiOlzZbA65EXYW5T
         4Efh7WUB5mXDgxdgpz3ErxMDszbI+EVZtXoUIlD7InrpJ8Lg7NnS7zwBs3ysSSllBQjW
         B24sEyue95/bE7QZ4td/NP8RWHQeo5P7X8kpRPMD+cdln41WxDJRD/VfWvNmj7jr+JmR
         lXg7DIfHAzk4pH3eWRQj2s4AsGEKmUI7iRKMiynjgiGWF3Qt2v3dDNQ4vp4iqa2AmHgy
         l7RA==
X-Gm-Message-State: APjAAAUAsogA1rq4ry943PoX6+920XJMNQ8Fe3+JRRrwz1+bL9tpnZXR
        KA4otCseSz14CilunNsOQiHcVQKOAOc=
X-Google-Smtp-Source: APXvYqyrOgNBh3quDHMJVl6ILGuxddDkKPP6rBQ+oFb7GG/5HGQ/FvsKzXhjCK/JDGuSJw+RE1Be5w==
X-Received: by 2002:adf:db41:: with SMTP id f1mr25303742wrj.351.1573578147017;
        Tue, 12 Nov 2019 09:02:27 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p4sm23274824wrx.71.2019.11.12.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 09:02:26 -0800 (PST)
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com> <1ja79b4mje.fsf@starbuckisacylon.baylibre.com> <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com> <1j8sou4u1g.fsf@starbuckisacylon.baylibre.com> <7ec2e682-cfec-395e-cf38-58f050440c40@amlogic.com> <1j7e4e4sab.fsf@starbuckisacylon.baylibre.com> <dee789ae-6825-3f4c-16e7-227e064562d6@amlogic.com> <1j5zjy4fif.fsf@starbuckisacylon.baylibre.com> <399e3fda-91c0-6dcb-5040-a117fe78519d@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Nan Li <Nan.Li@amlogic.com>, Jianxin Pan <Jianxin.Pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "linux-amlogic\@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
In-reply-to: <399e3fda-91c0-6dcb-5040-a117fe78519d@amlogic.com>
Date:   Tue, 12 Nov 2019 18:02:25 +0100
Message-ID: <1jftitf2ou.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Thu 07 Nov 2019 at 04:07, Nan Li <Nan.Li@amlogic.com> wrote:

> On 2019/11/5 21:30, Jerome Brunet wrote:
>> 
>> On Tue 05 Nov 2019 at 10:05, Nan Li <Nan.Li@amlogic.com> wrote:
>> 
>> Nan Li, please fix your mailer to use plain text properly, your reply
>> are near impossible to read
>> 
> Sorry, maybe there is something wrong with my email address. Please help 
> me check whether my reply is in accordance with the format.
>

Please use plain text instead on html when replying on these mailing list.
