Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4727619
	for <lists+linux-mmc@lfdr.de>; Thu, 23 May 2019 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfEWGh4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 23 May 2019 02:37:56 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38361 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfEWGh4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2019 02:37:56 -0400
Received: by mail-wr1-f48.google.com with SMTP id d18so4853333wrs.5
        for <linux-mmc@vger.kernel.org>; Wed, 22 May 2019 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=n4//uQUu2E1QbNvWcW0MRfDsO1tyvhesEZ9tZvWdn2I=;
        b=Q2TwN7iTEZ9ISI2Qc6K8mjXLhRnyoSXzWvG8CV+8twlk8Y86cGPRKU/ds6SYgiNmJS
         bg07hw13OXw4u5yEU4NW8taNacKgrV3KOm1dtMZhns36KxF08eQxTGkW/paFqWWrm0UK
         h6kbMFSCUhY/sxjYdpOow7Ga4TbolG8427q2UelrCSX9oZmcslOZGHU8hW9vnaRXv22N
         /eta40N1rwjhNUn4A1Ku/p5Gij7qKpEkgVU955c3i9EvxcnkNZObXAA60Mvn+62aH/YR
         Cj1oQmvH1He5qXfv4KjU+ZyAds0LBgnAFjvxm4UkpkVK5uXyzyVm4GA4363jBXaPDpFD
         KwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=n4//uQUu2E1QbNvWcW0MRfDsO1tyvhesEZ9tZvWdn2I=;
        b=mgFEYpNbrHkSvBx981Drj8eOJgOuyyq5QlWoQfOgba1TJQLVubilaVZDGFJ7XN5Ib9
         RQ+RA/z2nO7H4DSEeT63L+55sTh70/6/xJPBrsA3qkkyz6epwKctB30kC4aKlUjS/mAq
         fDxZCBDdSQ4MAqqSG3la9vOh7jDVbNrC0MXjqxUyUlUr1dszWq3YhFEQNe2KTDvRkNFB
         FJwLCEKf06Izea4ASCIGmZHdEZlM8lbuqxlHiXADalNGpd4AMXevalqFl+umX39p1vog
         0zwV1qheaIAlEB8twIu4TZncRaC12uwCiOK6PmKBuixTO4H4A/7lO5Hh0A4DtpYtkxof
         z7Kg==
X-Gm-Message-State: APjAAAVpZedblAHCxSigJC0lT29T0bfvqqxmy5Oy2ABonU/yfzLd4hmG
        i4Kclhx/vKbYwu5sqzeTd2WAzU/KDj6dwLaUs//Mlwsh
X-Google-Smtp-Source: APXvYqwPNBmmoZzfDsJaZJvIXBrL5T6QGRQ07Feaj4nkeTfLnyM5FBiaxp9tXrnyV4nVIazMeWY3WlYvusbG2aBlWpc=
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr31521462wrp.37.1558593474808;
 Wed, 22 May 2019 23:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv35uPKE9pwmktVMg4wqyX7C7WYfdKV89uQkTfGMnEqpQXA@mail.gmail.com>
In-Reply-To: <CAAfyv35uPKE9pwmktVMg4wqyX7C7WYfdKV89uQkTfGMnEqpQXA@mail.gmail.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Thu, 23 May 2019 08:37:44 +0200
Message-ID: <CAAfyv37Fy0iWY2G=8yZXg2DU4oZ_8h0JEOgm1g2+McM8t-EfFA@mail.gmail.com>
Subject: Fwd: switch to bus width 8 failed
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

I'm facing on my custom board issue with slow eMC write speed. When
checked debug information I see that bus width is only 4 bit (while HW
connection using 8 bit and in dts I've setup also 8):

cat /sys/kernel/debug/mmc0/ios
clock:          52000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    1 (mmc high-speed)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

and in bootlog I see:
[    4.001992] mmc0: switch to bus width 8 failed

eMMC is sandisk (8G). Using mainline 4.12 kernel. IS there any way how
to debug this issue or someone experiencing similar? Thanks.

BR,

marek
