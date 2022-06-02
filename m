Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9453BD5D
	for <lists+linux-mmc@lfdr.de>; Thu,  2 Jun 2022 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiFBRc0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 2 Jun 2022 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiFBRcQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2022 13:32:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211E12AA9
        for <linux-mmc@vger.kernel.org>; Thu,  2 Jun 2022 10:32:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f34so9509200ybj.6
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2022 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AOKjTrvtE42zK5uWqDocg6EMLlmjIqUVdX1I8bBJjIQ=;
        b=gHmtvapXYqB0zzK8OHRSzwMgnOWQ0RdFJ04ywRiOEMt9m6Wi+ju9AhjZbHx1WuZCcr
         YkVJNxh6WkL3mpxEp91ijOeNOjbkMfLPCpVMAk02Leim3WoU4UsZXszca0BH5EiR9Yc6
         MNXFouMuzjtAHj13I2j68Oq7GcBdo0qTBgR5zQNEpMlTNb3/J1C9WOmBSNuoWd7FM/F7
         MQRDAvN3Pfoq1J2bP3fx4awa9PZXnoRTswcpY2tO2LecbchBxynBXuDRvzVW/VhNRDP1
         bknP95XX3OoELX/q4JBWPJ2MKEeenQL5jKA7CFN82dMm93kp846zYdA1yMXy+fU4cxEc
         9G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=AOKjTrvtE42zK5uWqDocg6EMLlmjIqUVdX1I8bBJjIQ=;
        b=lEV4tL/Vcyjatz9Db7Ef7atNpvdW+GvhyLxNqvYHUzDmcTA8CYpWseU5RCdUKw+xiJ
         v1wkGniEG+sT8OIe9rbOwifUx+waCXp2JT718zmQTCAYruTcsxhGGWPCeUhOyChYjaSy
         rywspnocCD3c5j7uZtT9urccwCzDE3W0HIrbZdPP41mDeKqyc8AlvldFEtcKC63qlepC
         KpTZanZjBvy0LpBQE2u9KR41oStDjqgG2xBhOn31RGn4/T3+0HqqcJaxAHGTe7XV1gsd
         6fZdvutOQhy+ynW770CgtNq/XqvV+KvolRC921VYF8HzonjA4HcEA0KqB6VXJakEC+my
         DKcw==
X-Gm-Message-State: AOAM532esIqGJEZA+VAEggFS9N47XBhFjWNHC58r9uZEf2QLoge4Yh8Z
        QHF6UIaHGf9uqLti2b2Qy9ViQpHkvj6IKc7e4j8=
X-Google-Smtp-Source: ABdhPJz5PGsqm8cjmRuxfWklLuNlLq4TpqvnImMtE1KgnG7AX5ndmNGqnAwwvQzDPilX0LV4VRq0QfgqbvW7V3pnbkg=
X-Received: by 2002:a25:824a:0:b0:65c:bf2a:265 with SMTP id
 d10-20020a25824a000000b0065cbf2a0265mr6786660ybn.225.1654191133593; Thu, 02
 Jun 2022 10:32:13 -0700 (PDT)
MIME-Version: 1.0
Sender: mrjerberzarbo20@gmail.com
Received: by 2002:a05:7000:af94:0:0:0:0 with HTTP; Thu, 2 Jun 2022 10:32:12
 -0700 (PDT)
From:   Mr Vlad Liubich <vladliubich@gmail.com>
Date:   Thu, 2 Jun 2022 17:32:12 +0000
X-Google-Sender-Auth: UX-djgAGgeFi1p-aQ4rHlYoIuD4
Message-ID: <CAN6BFDvFkLAw7tg8xd1-xNoNN+11+qAcTypbh4vXJHZHzH0F1A@mail.gmail.com>
Subject: Good day my respected friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Good day my respected friend,

The internet has been grossly abused by scam artists and miscreants
whose intention is to hurt people. As much as one should be careful,
at the same time we should not allow negative to kill the positive
potential in a realistic proposal such as this, please read my
proposal carefully and it is 100% Risk-free.

I am Vlad Liubich =E2=80=93 A part of production Directors - PJSC AZOVSTAL
IRON & STEEL WORKS, Ukraine, due to the conflict between my country
Ukraine and Russian, the Russian troops surrounded my workplace,
inching closer each day, and my workplace come under heavy bombardment
has been devastating. The sprawling dockside steelworks and its maze
of underground passageways has become the last pocket of Ukrainian
resistance in the southern port city of Mariupol, and we were under
high tension and our lives are not secured for now.

Before the Russian troops surrounded my workplace and the heavy
bombardment, I sent out my digital safe box containing my life
savings, =E2=82=AC18,600,000,000 Euro (Eighteen Million Six hundred thousan=
d
Euro) through a courier express delivery company flying from Ukraine
to CAMBODIA, and they were kept under the custody of their security
and financial company under insurance policy for security purpose.

 I am seeking your urgent assistance to help secure the funds from the
security and finance company in Cambodia to your country for the
safety of the funds, they are my last hope, you will take 40% and keep
60% safe for me and my family.

Azovstal covers an area of almost 11 square kilometers and has a
labyrinth of underground tunnels stretching 24 kilometers and that was
where we are hiding at the moment as I wait for paperwork to evacuate
with my family, no phone communication here due to the result of the
heavy bombardment; I can only communicate you through internet. If you
are interested in assisting with transparency, kindly reach me back
urgently for further steps to follow.

Mr. Vlad Liubich.
