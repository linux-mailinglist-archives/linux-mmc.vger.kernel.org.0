Return-Path: <linux-mmc+bounces-9959-lists+linux-mmc=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-mmc@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBO6FDumb2kfEgAAu9opvQ
	(envelope-from <linux-mmc+bounces-9959-lists+linux-mmc=lfdr.de@vger.kernel.org>)
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Jan 2026 16:58:51 +0100
X-Original-To: lists+linux-mmc@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63046EB5
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Jan 2026 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCFFF7A8F36
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Jan 2026 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838A44BCA5;
	Tue, 20 Jan 2026 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVA+yYZs"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8442E004
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921010; cv=none; b=SkARzHk6ioO6rM5NujhwvHEsSD7utgtdrKkq6QJTlRc1LjByzdZjMEP2GtKCeVX+CiX8IBWabc2UmPm06nn44ui7C+o6fDjApyB5p/y2k8SEsqYoWIYG865L3v+KfDR4CcYljHAbs0YPctoA6VJ14sE+jYoWwffilU6a3nUyQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921010; c=relaxed/simple;
	bh=aiiF64/Crg7D0thgOrGHT16eEW2iJPzVrHJ8ClGguUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HeXlRAGxicmHuScYqVtU3Ht0dEkBvYbRdHk3+qo5dTQ37V1CEujJP+o6j4I50n9Olw/4TS+JYCoT0CaqidJyDyoJ+lL/qkJtQvhrLv5bdeJt3DJ7hRu/DhC9bTx4b7qa/+dnl8PonJc46DpMiELyS0l1BnIBFXsP+trJu06GdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVA+yYZs; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1E5FEC214F2;
	Tue, 20 Jan 2026 14:56:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3084C606AB;
	Tue, 20 Jan 2026 14:56:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1561410B6B50F;
	Tue, 20 Jan 2026 15:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768921006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aiiF64/Crg7D0thgOrGHT16eEW2iJPzVrHJ8ClGguUg=;
	b=SVA+yYZsLizZPszL9kCEbpybr/096vW3WoAgn5ESvGj72kbE4npo40K+KYFqX6Mwa+wesz
	qZ369/wSNsFqskcVjB18pk9N4MVIkuJ8TuAurWAm5a7Sir4ZdqYkxkBIa5WHYPvNconQdB
	lKMUD3wVT1JasLD06a4hb0tVWY6T7Eaz0D7ytdwX5tPzZjVZEjEcutTlMJ9FqktTfGPT+l
	wr10SrIJhEjfgMjpBzaIyBNz9Z6u13tyg409xGoY7ChlzkAXYGeeo6vvUW/e7dTrpKUyTU
	/mHItJvMFHGEnbbpQKl3O5m44eQAMG/jzuwvnbkSNN5wMY4swjRvxkWuknMk1A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Brian Norris <computersforpeace@gmail.com>,
  Kamal Dasu <kdasu.kdev@gmail.com>,  William Zhang
 <william.zhang@broadcom.com>,  Nick Terrell <terrelln@fb.com>,  David
 Sterba <dsterba@suse.com>,  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>,  Simon Glass
 <sjg@chromium.org>,  Linus Walleij <linusw@kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>,  Marcus Folkesson <marcus.folkesson@gmail.com>,
  Tony Lindgren <tony@atomide.com>,  Roger Quadros <rogerq@kernel.org>,
  Hauke Mehrtens <hauke@hauke-m.de>,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mmc@vger.kernel.org
Subject: Re: [PATCH 00/10] dt-bindings: mtd: Partition binding fixes and
 restructuring
In-Reply-To: <CAL_JsqJ7_yKRTCOrxcq0QDy_MRMCRMQqhH=TKiBs=nubqNN9HA@mail.gmail.com>
	(Rob Herring's message of "Mon, 19 Jan 2026 19:54:24 -0600")
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
	<87tswhswsp.fsf@bootlin.com>
	<CAL_JsqJ7_yKRTCOrxcq0QDy_MRMCRMQqhH=TKiBs=nubqNN9HA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 20 Jan 2026 15:56:38 +0100
Message-ID: <87ikcws57d.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nod.at,ti.com,kernel.org,gmail.com,broadcom.com,fb.com,suse.com,milecki.pl,chromium.org,linaro.org,atomide.com,hauke-m.de,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9959-lists,linux-mmc=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,linux-mmc@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-mmc,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: DF63046EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

>> The series does not apply cleanly, I tried mtd/next and then
>> v6.19-rc1. Can you please rebase it and fix the conflicts (at least 2
>> patches fail, and then I stopped)?
>
> I rebased on mtd/next and sent v2. I only saw one conflict though, and
> that was with seama.yaml. That's going to conflict with Linus' tree,
> but the resolution is take the deleted file.

I didn't see where this seama file was modified, except for Linus W.'s
address change. Is there an -rc I need to pull? Or an immutable tag?

Maybe this series applies on top of your next branch? I can give an ack
for the full series if that's the case and you can take it.

I generally try my best to avoid conflicts at merge.

Thanks,
Miqu=C3=A8l

