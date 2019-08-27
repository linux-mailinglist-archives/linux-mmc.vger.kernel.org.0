Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E19E188
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfH0IMz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 04:12:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44952 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfH0IMy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 04:12:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id c7so12841501vse.11
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXr7hOEZ00P48wv2crSNIZ7D4PZktGsC5UA/Kuk48kE=;
        b=fkunok9cyNdAeJnRuGL8c+W5FHp1kN8kUrKNHIQfUBjED7chQj/AuMlEnisvwNZFQB
         dayL3zMXAB1ZaAM4putkeDxa1seof99AYrfoXjVmfpzWpnUsyG2mH7enEkgDY97qI5kw
         FCWwozHGxXi2sGubAajWW1vAZYESn+RMkRUyYjT8dYErgbHXnXVcBLVQvfwCY0pAt/ls
         p6JmZnRzzJIIxmaTsGKaH21fllNK8RwgPsDzxi6kJJ8mC1FKGJ9OI0SqjvKqrofi+2AB
         SUsjYEVT4nscGrQMK0DPkDbkuZ+4DfK9MpZ0OVQc2IVW8AWIWpsBudJyF6C9hS1b1xkK
         8Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXr7hOEZ00P48wv2crSNIZ7D4PZktGsC5UA/Kuk48kE=;
        b=FCaDG0zY55cago/W6bA85IYmiZxDxxbELQu30+dj17y6Qu82mj0n99gpDWEKvPazPi
         i4oCBlzpHHByu3Pf2ql/h5JaV8GiFVwS8hlR8tEzWVUP3cNKL1lYAuwMmXT18QjWbKvQ
         cAj4rK0DRHds19Z2uGpLMdDs0FdpqtJPX6JpVH4bAChkSe+CPNaRu3C7pS0l63WLIzVU
         +Dsvli2aCEKgxl2fM0jnHMoNgU0sBxFhV85T5laUb/KvSSXP54e8+GkPtlo0bI6i1euA
         3gQA59GhtYBBv9/FxbPD/qkloLgIZmNOK3j539LIUHaGSZbPSx+DalJRod6ty09h7RTp
         eVGA==
X-Gm-Message-State: APjAAAUajezh4udW1ClOhF47ZRV+TVEo3LhhhoMj3qAqRouxu9aqmtgA
        D2qEQSAGaL/Q1nPclPrr3NxvfwIILVMrpuvbIdlhxes6
X-Google-Smtp-Source: APXvYqxVXdnUjF0pjO9dOo60Rp4g9QqY3qaJckKAIH7hf2YlaZLmqQWzr34yAbY+zxuqxtH1q8lIWSODXwWNqsIuCLE=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr12842475vsy.191.1566893572584;
 Tue, 27 Aug 2019 01:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190811021917.29736-1-philipl@overt.org> <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
 <41d073f646b1f94adcf41b2cf0f798d8@overt.org> <20190824152530.432fe9a2@fido6>
 <CAPDyKFq3o-StNCuNA3vy8uW5pO=eu1BheQXyT4ftmfhuPSUnBg@mail.gmail.com>
 <03f692ac16a1854ee18f5526f8a53530@overt.org> <20190826203149.1354d8c8@fido6>
In-Reply-To: <20190826203149.1354d8c8@fido6>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 10:12:15 +0200
Message-ID: <CAPDyKFp9oT=ouyTkTUizm0Lx-akehG5sapPV5CXzYp90HWiAgA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
To:     Philip Langdale <philipl@overt.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 05:31, Philip Langdale <philipl@overt.org> wrote:
>
> On Mon, 26 Aug 2019 11:06:26 -0700
> Philip Langdale <philipl@overt.org> wrote:
>
> >
> > I started looking at how we might make a general change to ignore for
> > all
> > cards, and in the process, I saw that we already have a way to
> > differentiate
> > ocr_avail for different card types, and the sdhci driver uses this to
> > elide the low voltage range when dealing with SD cards. So I've made
> > the small change to have the rtsx drivers set ocr_avail_sd and skip
> > the low voltage
> > range support. This makes the cards work, as you'd expect.
> >
> > There's still a fair claim that the elidation logic should move into
> > the core,
> > so that all host controllers automatically benefit, but I think I
> > should leave
> > that to you. It's a core change and I don't pretend to understand all
> > the
> > considerations for all the various supported controllers.
> >
> > I've sent a new diff with the rtsx-specific fix.
> >
>
> More reading == more thoughts.
>
> So, I went through the simplified 6.0 spec more carefully and this is
> what I've extracted:
>
> * Low Voltage Signalling: The 1.8V I/O voltage we already support
> * Low Voltage Interface: A new 6.0 feature for setting VDD to 1.8V

I have the full specs available, as Linaro is a member of the SD Association.

I can't find anything that confirms that "Low Voltage Interface" has
anything to do with the supply voltage (VDD). It's all about signaling
voltage, unless I am mistaken somehow.

All I can find for VDD (or VDD1) is that it always needs to stay
between 2.7V - 3.6V.

>
> The LVI is documented in the "Low Voltage Interface Addendum" that is
> not included in the simplified spec. Why? Who knows. Do you have access
> to this by any chance?

I have the spec.

The below is stated in the initial part from the LVI addendum.

"There has been a demand of low voltage signaling interface memory
card for especially mobile host
devices. To meet the demand, this addendum defines low voltage
signaling interface in SD mode
(called "LVS interface") that starts in 1.8V signaling UHS-I mode
without going through 3.3V signaling,
that is host can start card communication in SDR12 mode from the start
of initialization and skips
Voltage Switch Sequence (CMD11). "LVS" denotes Low Voltage Signaling
for communication lines but
3.3V power supply is still used."

>
> There are specific references in the simplified spec when discussing
> the OCR that make it pretty clear that bit 7 in the OCR indicates the
> card supports LVI and can be initialised in 1.8V mode if the LVI
> negotiation is followed.

Actually no, I don't think so. Bit7 in OCR is a very old thing and
it's about "dual voltage cards" and not LVI.

I did some more research to really understand. By searching for "dual
voltage" in the spec(s) and bit7 in OCR. I found it being introduced
already in version 2.00.

Then I realized that the current text in 7.1, is a leftover that
should have been removed altogether and not only parts as was done in
version 3.01. My guess, is that it was probably introduced while the
"eSD" spec was being developed, as an alternative to eMMC.

Additionally, reading the LVI addendum and especially the LVI
initialization sequence for a LV compatible host+card, I found nothing
that mentions bit7 in the OCR register.

>
> There is also a clear statement that an A2 card must support LVI.
>
> That means that the Sandisk card I'm looking at is 'correctly' setting
> bit 7 in OCR to indicate LVI support. And there's no "LV" logo because
> A2 implies LVI.
>
> It's deeply annoying that Low Voltage initialisation is done
> differently for SD vs MMC despite using the same mechanism to indicate
> support.
>
> Overall, this implies that until we can implement LVI negotiation, it
> would be semantically correct to ignore bit 7 explicitly for SD cards,
> and hopefully we'd eventually be able to implement the negotiation and
> support low voltage VDD when the controller and card support it.

According to the above, I don't think we ever need to care about bit 7
in the OCR. But yes, supporting LVI may be complicated, but that's
another story. :-)

Anyway, I decided to post a patch, please test it at your side and see
if it fixes the problem for you.

Kind regards
Uffe
